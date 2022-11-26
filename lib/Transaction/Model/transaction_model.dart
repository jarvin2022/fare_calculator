import 'package:farecalculator/packages.dart';

class TransactionModel {
  final String? transactionID;
  final LatLng? transactionStartLocation;
  LatLng? transactionEndLocation;
  final RxString transactionDistance = '0 m'.obs;
  final RxString transactionDuration = '0 ms'.obs;
  DateTime startDate = DateTime.now();
  final int? numberOfPassenger;

  //Base rate
  RxDouble transactionBaseRate = 0.0.obs;

  //Additional Rate
  RxDouble transactionRate = 0.0.obs;

  //Total payment
  final RxDouble transactionFare = 0.0.obs;

  TransactionModel(
      {this.transactionID,
      this.transactionStartLocation,
      this.transactionEndLocation,
      this.numberOfPassenger});

  void initializedBaseFareRate(double rate) => transactionBaseRate.value = rate;

  void initializedFareRate(double rate) => transactionRate.value = rate;

  void updateDistance(String distance) {
    transactionDistance.value = distance;
    retrieveFare();
  }

  //Additional fee for number of passenger
  double additionalFee() =>
      numberOfPassenger! > 2 ? (numberOfPassenger! - 2) * 5 : 0;

  double additionalFeePerRate() {
    var distance = transactionDistance.value.split(' ');

    if (distance[1] == 'km') {
      double distanceTemp = double.parse(distance[0]);

      //Subtract 1km on value distance
      distanceTemp -= 1;

      //difference of distance - 1km( minimum distance of base rate) multiply to additional rate fee for succeeding distance
      return distanceTemp * transactionRate.value;
    }

    //Return additional base on per km rate if less than 1km
    return 0;
  }

  String additionNameFee() => PriceClass().priceFormat(additionalFee());

  double get distanceTravel =>
      double.parse(transactionDistance.value.split(' ')[0].toString());

  String get numberOfPassengerOnBoard => (numberOfPassenger!).toString();

  //// [additionalFeePerRate] get additioal fare for succeding distance if exceed 1km( minimum base rate distance)
  //// [additionalFee] get additional fee for number of customer

  void retrieveFare() {
    double addFee = additionalFee();
    double total = transactionBaseRate.value + additionalFeePerRate() + addFee;
    transactionFare.value = total;
  }
}
