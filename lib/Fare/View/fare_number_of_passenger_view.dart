import 'package:farecalculator/packages.dart';

class FareNumberOfPassenger extends GetView<UserController> {
  const FareNumberOfPassenger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InputDecorator(
        decoration: const InputDecoration(
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            border: InputBorder.none),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            items:
                controller.hcontroller?.numberOfPassenger.map((String value) {
              return DropdownMenuItem(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextWidget(
                      title: value,
                      fontSized: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ));
            }).toList(),
            value: controller.hcontroller?.numberOfPassenger[
                controller.hcontroller!.selectedNumberOfPassenger.value],
            isDense: true,
            onChanged: (newValue) {
              controller.hcontroller!.selectedNumberOfPassenger.value =
                  controller.hcontroller!.numberOfPassenger
                      .indexOf(newValue!.toString());
            },
          ),
        ),
      ),
    );
  }
}
