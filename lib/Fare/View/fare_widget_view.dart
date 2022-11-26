import 'package:farecalculator/packages.dart';

class FareWidgetView extends GetView<FareController> {
  const FareWidgetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width,
        height: 140,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: Get.width,
            height: 120,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 78, 176, 18),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => TextWidget(
                          title:
                              'Base Rate: ${PriceClass().priceFormat(controller.fare.value?.fareBaseRate.value ?? 0)}',
                          fontSized: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      TextWidget(
                        title: DateFormatClass.getDateTime(
                                controller.fare.value?.fareDate ??
                                    DateTime.now())
                            .getTodayDateToString(),
                        fontSized: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 79, 88, 88),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(
                        title: 'Total Passenger',
                        color: Color.fromARGB(255, 79, 88, 88),
                        fontSized: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      Container(
                          width: 120,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: FareNumberOfPassenger(),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
