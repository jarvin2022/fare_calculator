import 'package:farecalculator/main.dart';
import 'package:farecalculator/packages.dart';

class FareController extends GetxController {
  final TextEditingController baserate = TextEditingController();
  final TextEditingController rate = TextEditingController();

  Rxn<FareModel> fare = Rxn<FareModel>(null).obs();

  RxString exception = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializedFareSetting();
  }

  void initializedFareSetting() async {
    try {
      DocumentSnapshot json = await requestGetFareCollection();
      if (json.exists == false) {
        bool status = postFareSetting();
        if (status) initializedFareSetting();
        return;
      }
      fare.value =
          FareModel.fromJSON(json.data() as Map<String, dynamic>, json.id);
      fare.value!.fareBaseRate.value =
          double.parse(json.get('fare_base_rate').toString());
      fare.value!.fareRate.value =
          double.parse(json.get('fare_rate').toString());
    } catch (e) {
      exception.value = e.toString();
    }
  }

  Future<DocumentSnapshot> requestGetFareCollection() async {
    return await firebaseFirestore
        .collection(userCollection)
        .doc(firebaseAuth.currentUser!.uid)
        .collection(fareCollection)
        .doc(firebaseAuth.currentUser!.uid)
        .get();
  }

  bool postFareSetting() {
    firebaseFirestore
        .collection(userCollection)
        .doc(firebaseAuth.currentUser!.uid)
        .collection(fareCollection)
        .doc(firebaseAuth.currentUser!.uid)
        .set({
      'fare_date': DateTime.now(),
      'fare_distance': '1 km',
      'fare_base_rate': 25,
      'fare_rate': 5,
    }).catchError((err) {
      return;
    });
    return true;
  }

  void updateBaseRate() => requestUpdateBaseRate();

  void requestUpdateBaseRate() {
    firebaseFirestore
        .collection(userCollection)
        .doc(firebaseAuth.currentUser!.uid)
        .collection(fareCollection)
        .doc(firebaseAuth.currentUser!.uid)
        .update({
      'fare_base_rate': double.parse(baserate.text),
      'fare_rate': double.parse(rate.text),
      'fare_date': DateTime.now(),
    }).then((_) {
      initializedFareSetting();
      Get.back();
    });
  }
}
