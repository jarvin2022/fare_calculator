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
          title: 'Account ',
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
                        'Change base rate or fare rate per km, commuter must follow the standard rate of municifality if caught manipulating the fare rate will pay double the fare of the transaction ',
                  ),
                ),
                const SizedBox(height: 40),
                TextFormWidget(
                  prefixIcon: Icons.rate_review_rounded,
                  controller: controller.baserate,
                  label: 'Base rate',
                ),
                const SizedBox(height: 30),
                TextFormWidget(
                  prefixIcon: Icons.rate_review_rounded,
                  controller: controller.rate,
                  label: 'Additional Rate',
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: Get.width,
                  child: MaterialButton(
                    color: const Color.fromARGB(255, 78, 176, 18),
                    onPressed: () {
                      controller.updateBaseRate();
                    },
                    child: const TextWidget(
                      title: 'Save',
                      fontSized: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
