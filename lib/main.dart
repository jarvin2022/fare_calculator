import 'package:farecalculator/History/View/report_rider_view.dart';
import 'package:farecalculator/Home/View/scan_qr_view.dart';
import 'package:farecalculator/packages.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:farecalculator/Home/View/home_view.dart';
import 'package:farecalculator/Transaction/View/transaction_view.dart';
import 'package:farecalculator/firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(UserController());
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fare Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LoadingView(),
      initialBinding: BindController(),
      getPages: [
        GetPage(name: outerRoute, page: () => const LoadingView()),
        GetPage(name: loginRoute, page: () => const AuthSigninView()),
        GetPage(name: signupRoute, page: () => const AuthSignupView()),
        GetPage(name: recoverRoute, page: () => const AuthRecoverAccount()),
        GetPage(name: userRoute, page: () => const AuthSetUserInformation()),
        GetPage(name: homeRoute, page: () => const HomeView()),
        GetPage(name: rateRoute, page: () => const FareUpdateView()),
        GetPage(name: aboutRoute, page: () => const AboutView()),
        GetPage(name: historyRoute, page: () => const HistoryView()),
        GetPage(name: termsRoute, page: () => const TermsView()),
        GetPage(name: aboutRoute, page: () => const AboutView()),
        GetPage(name: accountRoute, page: () => const AccountView()),
        GetPage(
            name: passwordRoute, page: () => const AccountChangePasswordView()),
        GetPage(name: transactionRoute, page: () => const TransactionView()),
        GetPage(name: scanRoute, page: () => const ScanQrView()),
        GetPage(name: reportRoute, page: () => const ReportRiderView())
      ],
    );
  }
}
