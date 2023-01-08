import 'package:farecalculator/History/Model/user_rider_model.dart';
import 'package:farecalculator/main.dart';
import 'package:farecalculator/packages.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class HistoryController extends GetxController {
  RxList<HistoryModel> historyList = RxList<HistoryModel>([]).obs();
  Rxn<UserModelRider?> rider = Rxn<UserModelRider>(null).obs();
  final TextEditingController report = TextEditingController();

  RxBool sendReport = false.obs;

  @override
  void onInit() {
    super.onInit();
    initStream();
  }

  void initStream() => historyList.bindStream(historyStream());

  Stream<List<HistoryModel>> historyStream() {
    List<HistoryModel> list = [];

    Stream<QuerySnapshot> res = firebaseFirestore
        .collection(historyCollection)
        .where('history_userID', isEqualTo: firebaseAuth.currentUser!.uid)
        .snapshots();

    res.listen((response) {
      if (response.docs.isNotEmpty) {
        list.clear();
      }
    });

    return res.map((response) {
      for (QueryDocumentSnapshot document in response.docs) {
        if (document.get('history_userID') == firebaseAuth.currentUser!.uid) {
          list.add(HistoryModel.toJson(
              document.data() as Map<String, dynamic>, document.id));
        }
      }
      return list.toList();
    });
  }

  void removeHistory(int index, String id) => requestDeleteDocument(index, id);

  void requestDeleteDocument(int index, String id) async {
    try {
      historyList.removeAt(index);
      firebaseFirestore.collection(historyCollection).doc(id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void reportSendToEmail()async{
    try{
      final Email email = Email(
        body: report.text,
        subject: 'Report Rider',
        recipients: ['tristanjayamit0813@gmail.com'],
        isHTML: false,
      );

      

      await FlutterEmailSender.send(email).then((value) => sendReport.value = true)
        .onError((error, stackTrace) => throw Exception(error));
    }catch(e){
      print(e.toString());
    }
  }

  void getRiderInfo(String id)async{
    DocumentSnapshot data = await firebaseFirestore.collection("Driver_Collection").doc(id).get();
    rider.value = UserModelRider.fromJson(data.data() as Map<String, dynamic>, id);
    Get.toNamed('/report');
  }

}
