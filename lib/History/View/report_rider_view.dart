import 'package:farecalculator/packages.dart';

class ReportRiderView extends GetView<UserController>{
  const ReportRiderView({Key? key}):super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          width: Get.width,
          height: 35,
          color: const Color.fromARGB(255, 78, 176, 18),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1),
            ], borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 78, 176, 18),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                child: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      Get.back();
                      controller.hicontroller!.sendReport.value = false;
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ),),
      body: SafeArea(child: SingleChildScrollView(
        child: SizedBox(width: Get.width,height: Get.height * 0.78,child: 
          Column(children: [
              const SizedBox(height: 20),
              TextWidget(title: "Driver Name: ${controller.hicontroller!.rider.value!.userFirstName} ${controller.hicontroller!.rider.value!.userLastName}",fontSized: 16,
                fontWeight: FontWeight.w600,),
              TextWidget(title: "PLATE NUMBER: ${controller.hicontroller!.rider.value!.userPlateNumber}",fontSized: 16,
                fontWeight: FontWeight.w600),
              const SizedBox(height: 20),
              const SizedBox(width: 250,
                child: TextWidget(title: "Your report will be send to munifacility, we wil process your report and give proper punishment to tricycle drivers who violates the given policy."
                " Your name and address will be also attach on report for us to know who reports the driver to prevent abuse of report.",fontSized: 12,
                fontWeight: FontWeight.w500,textAlign: TextAlign.center,),),
      
              const SizedBox(height: 30),
              Obx(() => controller.hicontroller!.sendReport.isTrue?sendStatus():form()),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.only(left:18.0,right: 18.0),
                child: SizedBox(
                  width: Get.width,
                  height: 40,
                  child: MaterialButton(
                    color:Colors.red,
                    onPressed: () {
                      if(controller.hicontroller!.report.text != ''){
                        controller.hicontroller!.reportSendToEmail();
                      }
                    },
                    child: const TextWidget(
                      title: 'Report',
                      color: Colors.white,
                      fontSized: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],)
          ,),
      ),
        ),
    );
  }

  Widget sendStatus () {
    return Padding(
                padding: const EdgeInsets.only(left:18.0,right: 18.0),
                child: SizedBox(width: Get.width,height: 200,child:
                  Column(children: const[  TextWidget(title: 'Your Report has been sent',fontSized: 14,fontWeight: FontWeight.w600,),
                      SizedBox(height: 20),
                      Icon(Icons.check_circle_rounded,color: Colors.green,size: 130,)
                  ,],)
                ),
              );
  }

  Widget form(){
    return Padding(
                padding: const EdgeInsets.only(left:18.0,right: 18.0),
                child: SizedBox(width: Get.width,child:
                  Column(children: [ const TextWidget(title: 'State Your Report Here',fontSized: 14,fontWeight: FontWeight.w600,),TextFormField(
                    controller: controller.hicontroller!.report,
                    keyboardType: TextInputType.text,
                    maxLines: 10,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        enabled:  true,
                        focusColor: Colors.green[400]),
                  ),],)
                ),
              );
  }
} 