import 'package:farecalculator/packages.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {Key? key,
      this.controller,
      this.hint,
      this.label,
      this.textInputType,
      this.prefixIcon,
      this.obscureState,
      this.enabled})
      : super(key: key);

  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hint;
  final String? label;
  final IconData? prefixIcon;
  final bool? obscureState;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    RxBool obsStatus = true.obs;

    if (obscureState ?? false) {
      return Obx(
        () => TextFormField(
          obscureText: obscureState == true ? obsStatus.value : false,
          controller: controller,
          keyboardType: textInputType,
          decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(prefixIcon),
              label: TextWidget(title: label),
              border: const OutlineInputBorder(),
              suffixIcon: obscureState == null
                  ? null
                  : IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        obsStatus.toggle();
                        obsStatus.refresh();
                      },
                      icon: Obx(
                        () => Icon(obsStatus.isTrue
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )),
              enabled: enabled ?? true,
              focusColor: Colors.green[400]),
        ),
      );
    }
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(prefixIcon),
          label: TextWidget(title: label),
          border: const OutlineInputBorder(),
          enabled: enabled ?? true,
          focusColor: Colors.green[400]),
    );
  }
}
