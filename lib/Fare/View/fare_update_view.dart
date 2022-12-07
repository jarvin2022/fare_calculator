import 'package:farecalculator/packages.dart';

class FareUpdateView extends GetView<FareController> {
  const FareUpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextWidget(
          title: 'Fare Rate',
          fontSized: 20,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 79, 88, 88),
        ),
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
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          height: Get.height * 0.7,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              children: [
                const SizedBox(height: 25),
                SizedBox(
                    width: 200,
                    height: 200,
                    child: SvgPicture.asset('./assets/logo/map_logo.svg')),
                const SizedBox(height: 10),
                SizedBox(
                  width: Get.width * 0.8,
                  child: const TextWidget(
                    textAlign: TextAlign.center,
                    title:
                        'This is standard tricycle fare rate for Zamboanga City, strict policy drivers must follow the standard rate caught violating the policy will be fine.',
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(
                        title: 'Effective Starting ',
                        fontSized: 14,
                      ),
                      TextWidget(
                        title: DateFormatClass.getDateTime(
                                controller.fare.value!.fareDate!)
                            .getTodayDateToString(),
                        fontSized: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ]),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(title: 'Fare Base Rate '),
                      TextWidget(
                        title: PriceClass().priceFormat(
                            controller.fare.value!.fareBaseRate.value),
                        fontSized: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ]),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(title: 'Fare Additional Rate '),
                      TextWidget(
                        title: PriceClass()
                            .priceFormat(controller.fare.value!.fareRate.value),
                        fontSized: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ]),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(title: 'Distance '),
                      TextWidget(
                        title: controller.fare.value!.fareDistance,
                        fontSized: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ]),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
