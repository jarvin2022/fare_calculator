import 'package:farecalculator/packages.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io' show Platform;


class ScanQrView extends GetView<UserController>{
  const ScanQrView({Key?key}):super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Obx(() => Expanded(
              flex: 5,
              child: QRView(
                key: controller.hcontroller!.qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(borderColor: controller.hcontroller!.barCodeColor.value! ,borderWidth: 3,borderRadius: 15),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(children: [TextWidget(title:'Waiting for QR code.'.toUpperCase(),fontSized: 18,fontWeight: FontWeight.w600),
            MaterialButton(color: Colors.green,onPressed: ()async{
              await controller.hcontroller!.controller.value!.resumeCamera();
            },child: const TextWidget(title: 'Start Camera',fontSized: 14, color: Colors.white,))],),
          )
        ],
      ),
    );
  }
  
  void _onQRViewCreated(QRViewController controllers) {
    controller.hcontroller!.controller.value = controllers;
    controller.hcontroller!.controller.value!.scannedDataStream.listen((scanData) {
      if(controller.hcontroller!.qr.value == '' && controller.hcontroller!.checkingQR.isFalse){
          controller.hcontroller!.checkingQR.value = true;
          controller.hcontroller!.result!.value = scanData;
          controller.hcontroller!.qr.value = controller.hcontroller!.result!.value!.code!;
          controller.hcontroller!.checkQr(controller.hcontroller!.result!.value!.code!);
          
      }
    });
  }
}
