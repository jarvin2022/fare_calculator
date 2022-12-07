import 'package:farecalculator/packages.dart';
import 'package:location/location.dart' as loc;
import 'dart:async';
import 'package:farecalculator/main.dart';

class HomeController extends GetxController {
  GoogleMapController? googleMapController;
  final Completer<GoogleMapController> completer = Completer();

  final Rxn<Set<Polyline>> polylines = Rxn<Set<Polyline>>({}).obs();

  final Rxn<TransactionModel>? transaction = Rxn<TransactionModel>(null).obs();


  CameraPosition initialGooglePlex = const CameraPosition(
    target: LatLng(6.913584, 122.061091),
    zoom: 16.4746,
  );

  RxString exception = ''.obs;

  RxBool startJourney = false.obs;

  RxBool holdPolyline = false.obs;

  RxDouble baseFare = 0.0.obs;
  RxDouble rate = 0.0.obs;

  Rxn<LatLng> mypointLocation = Rxn<LatLng>().obs();

  Rxn<loc.Location> startingLocation = Rxn<loc.Location>(null).obs();

  Rxn<Directions?> dio = Rxn<Directions>(null).obs();
  // Rxn<Directions?> prevDio = Rxn<Directions>(null).obs();

  //Stream location of user
  Stream<loc.LocationData> myLocation = loc.Location().onLocationChanged;

  List<String> numberOfPassenger = ["1", "2", "3", "4", "5"];
  RxInt selectedNumberOfPassenger = 0.obs;

  @override
  void onInit() {
    super.onInit();
    myLocation.listen((loc) {
      if (holdPolyline.isTrue) {
        return;
      }
      if (transaction?.value == null) {
        mypointLocation.value = LatLng(loc.latitude!, loc.longitude!);

        return;
      }

      Timer(const Duration(milliseconds: 1000), () {
        updatePolyline(loc);

        transaction!.value!.transactionEndLocation =
            LatLng(loc.latitude!, loc.longitude!);

        //**
        //  Update transaction distance and also compute for updated fare
        // */
        if (dio.value != null) {
          transaction!.value!.updateDistance(dio.value!.totalDistance!);
        }

        //**
        //  Update transaction Duration of trip
        // */

        if (dio.value != null) {
          transaction!.value!.transactionDuration.value =
              dio.value!.totalDuration!;
        }

        //**
        //  move camera center to user location
        // */
        googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(loc.latitude!, loc.longitude!), zoom: 16)));
      });
    });
    dio.listen((p0) {
      if (p0 == null) {
        return;
      }
      mountPolyline();
    });
  }

  @override
  void onReady() {
    super.onReady();
    moveCameraToUser();
  }

  void moveCameraToUser() async {
    LatLng? myLocationPoint = await currentLocation();

    if (myLocationPoint != null) {
      googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: myLocationPoint, zoom: 16)));
    }
  }

  //// initialize new transaction
  /// initial start point and end point is current location
  /// distance as initial is 0 meter

  //// [selectedNumberOfPassenger] number of passenger, if passenger is greater than 1
  /// a 5 peso additional for the other passenger
  void startNavigation() {
    try {
      retrieveBaseFare();
      LatLng? startLocation = mypointLocation.value;

      if (startLocation != null) {
        transaction?.value = TransactionModel(
          transactionID: firebaseAuth.currentUser!.uid,
          transactionStartLocation: startLocation,
          transactionEndLocation: startLocation,
          numberOfPassenger: selectedNumberOfPassenger.value + 1,
        );

        transaction!.value!.initializedBaseFareRate(baseFare.value);
        transaction!.value!.initializedFareRate(rate.value);
        transaction!.value!.retrieveFare();
      }
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void retrieveBaseFare() {
    try {
      UserController userController = Get.find<UserController>();
      baseFare.value =
          userController.fcontroller!.fare.value!.fareBaseRate.value;
      rate.value = userController.fcontroller!.fare.value!.fareRate.value;
    } catch (e) {
      exception.value = e.toString();
    }
  }

  Future<LatLng?> currentLocation() async {
    try {
      loc.LocationData locationData = await loc.Location().getLocation();

      return LatLng(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      exception.value = ' currentLocation module';
    }
    return null;
  }

  void updatePolyline(loc.LocationData loc) {
    try {
      buildPolyline(transaction!.value!.transactionStartLocation!,
          LatLng(loc.latitude!, loc.longitude!));
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void updateTransaction() {
    transaction!.value!.transactionDuration.value = dio.value!.totalDuration!;
    transaction!.value!.transactionDistance.value = dio.value!.totalDistance!;
    double distance = double.parse(
        transaction!.value!.transactionDistance.value.split(' ')[0]);

    transaction!.value!.transactionFare.value = distance * baseFare.value;
  }

  void mountPolyline() {
    polylines.value!.add(Polyline(
      polylineId: const PolylineId('overview_polyline'),
      color: const Color.fromARGB(255, 78, 169, 18),
      width: 5,
      points: dio.value!.polylinePoints!
          .map((e) => LatLng(e.latitude, e.longitude))
          .toList(),
    ));
    polylines.refresh();
  }

  // If distance travel in 1 minute is less than 1 meter
  // then additional fee for fair will be added
  // for every 1 minute delay due to traffic fair will be added with value of 2 peso
  void checkForDistanceTravelInMinute() {}

  //build polyline for controller default polyline rx variable
  void buildPolyline(LatLng origin, LatLng destination) async =>
      dio.value = await createPolyline(origin, destination);

  Future<Directions?> createPolyline(LatLng origin, LatLng destination) async {
    return await DirectionsRepository()
        .getDirections(origin: origin, destination: destination);
  }

  void transactionComplete() async {
    holdPolyline.value = true;

    await firebaseFirestore.collection(historyCollection).add({
      'history_userID': firebaseAuth.currentUser!.uid,
      'history_distance': transaction!.value!.transactionDistance.value,
      'history_duration': transaction!.value!.retrieveTimeTravel(),
      'history_fare': transaction!.value!.transactionFare.value,
      'history_start_point':
          convertLatLngGeoPoint(transaction!.value!.transactionStartLocation!),
      'history_end_point':
          convertLatLngGeoPoint(transaction!.value!.transactionEndLocation!),
      'history_start_trip': transaction!.value!.startDate,
      'history_end_trip': DateTime.now(),
      'history_number_passenger': transaction!.value!.numberOfPassenger!,
    }).then((value) => resetTransaction());
  }

  void resetTransaction() {
    try {
      dio.value = null;
      transaction?.value = null;
      holdPolyline.value = false;
      Timer(const Duration(milliseconds: 300),
          () => Get.offAndToNamed(homeRoute));
      if (firebaseAuth.currentUser != null) {
        moveCameraToUser();
      }
    } catch (e) {
      exception.value = e.toString();
    }
  }
}
