import 'package:farecalculator/packages.dart';

class FareRate extends GetView<FareController> {
  const FareRate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextWidget(
        title:
            'Rate : ${PriceClass().priceFormat(controller.fare.value?.fareBaseRate.value ?? 0)}',
        fontSized: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}
