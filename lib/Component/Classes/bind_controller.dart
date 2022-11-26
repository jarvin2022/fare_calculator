import 'package:farecalculator/Home/Controller/home_controller.dart';
import 'package:farecalculator/packages.dart';

class BindController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<FareController>(() => FareController());
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
