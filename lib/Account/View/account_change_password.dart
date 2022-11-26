import 'package:farecalculator/packages.dart';

class AccountChangePasswordView extends GetView<UserController> {
  const AccountChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextWidget(
          title: 'Update Password ',
          fontSized: 20,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 79, 88, 88),
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
        flexibleSpace: Container(
          width: Get.width,
          height: 35,
          color: const Color.fromARGB(255, 78, 176, 18),
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: SizedBox(
                      width: Get.width,
                      height: Get.height * 0.82,
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: SvgPicture.asset(
                                './assets/logo/password_logo.svg'),
                          ),
                          const SizedBox(height: 15),
                          const TextWidget(
                            title:
                                'If you forget your password click the recovery Link a recovery account link will be sent to your email',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                          TextFormWidget(
                            prefixIcon: Icons.lock,
                            controller: controller.acontroller?.currentPassword,
                            label: 'Current password',
                            obscureState: true,
                          ),
                          const SizedBox(height: 20),
                          TextFormWidget(
                            prefixIcon: Icons.lock,
                            controller: controller.acontroller?.newPassword,
                            label: 'New password',
                            obscureState: true,
                          ),
                          const SizedBox(height: 20),
                          TextFormWidget(
                            prefixIcon: Icons.lock,
                            controller: controller.acontroller?.confirmPassword,
                            label: 'Confirm password',
                            obscureState: true,
                          ),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: SizedBox(
                                  width: Get.width,
                                  child: MaterialButton(
                                      color: Colors.blue,
                                      onPressed: () {
                                        controller.acontroller!
                                            .sentRecoveryToEmail();
                                      },
                                      child: const TextWidget(
                                        title: 'Recovery Link',
                                        color: Colors.white,
                                        fontSized: 14,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                flex: 1,
                                child: SizedBox(
                                  width: Get.width,
                                  child: MaterialButton(
                                      color: const Color.fromARGB(
                                          255, 78, 176, 18),
                                      onPressed: () {
                                        controller.acontroller!
                                            .updatePassword();
                                      },
                                      child: const TextWidget(
                                        title: 'Save',
                                        color: Colors.white,
                                        fontSized: 14,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
            Positioned(child: success()),
            Positioned(child: warning()),
            Positioned(child: error()),
          ],
        ),
      )),
    );
  }

  Widget success() {
    return Obx(
      () => controller.acontroller!.success.value != ''
          ? Container(
              width: Get.width,
              height: 50,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: controller.acontroller?.success.value ?? '',
                      color: Colors.white,
                      fontSized: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    IconButton(
                        onPressed: () {
                          controller.acontroller?.success.value = '';
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          : Container(),
    );
  }

  Widget error() {
    return Obx(
      () => controller.acontroller!.exception.value != ''
          ? Container(
              width: Get.width,
              height: 50,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: controller.acontroller?.exception.value ?? '',
                      color: Colors.white,
                      fontSized: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    IconButton(
                        onPressed: () {
                          controller.acontroller?.exception.value = '';
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          : Container(),
    );
  }

  Widget warning() {
    return Obx(
      () => controller.acontroller!.exception.value != ''
          ? Container(
              width: Get.width,
              height: 50,
              color: Colors.orange,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: controller.acontroller?.warning.value ?? '',
                      color: Colors.white,
                      fontSized: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    IconButton(
                        onPressed: () {
                          controller.acontroller?.warning.value = '';
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}
