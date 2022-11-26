import 'package:farecalculator/main.dart';
import 'package:farecalculator/packages.dart';

class AccountController extends GetxController {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController profile = TextEditingController();

  final TextEditingController currentPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  RxBool currentPasswordObscure = true.obs;
  RxBool newPasswordObscure = true.obs;
  RxBool confirmPasswordObscure = true.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;

  RxString exception = ''.obs;
  RxString warning = ''.obs;
  RxString success = ''.obs;

  @override
  void onReady() {
    super.onReady();
    UserController user = Get.find<UserController>();
    initializedControllers(user);
  }

  void initializedControllers(UserController user) {
    try {
      firstname.text = user.user.value?.userFirstName ?? '';
      lastname.text = user.user.value?.userLastName ?? '';
      address.text = user.user.value?.userAddress ?? '';
      if (user.user.value?.userProfileURl != 'NONE') {
        profile.text = user.user.value?.userProfileURl ?? 'NONE';
      }
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void updateAccount() => requestUpdate();

  void updatePassword() => requestUpdatePassword();

  void sentRecoveryToEmail() => requestRecoveryLink();

  void requestUpdate() async {
    try {
      if (validateTextControllers()) {
        return;
      }

      firebaseFirestore
          .collection(userCollection)
          .doc(firebaseAuth.currentUser!.uid)
          .update({
        'user_first_name': firstname.text,
        'user_last_name': lastname.text,
        'user_address': address.text,
      });

      success.value = 'Updated successfully.';
    } catch (e) {
      exception.value = e.toString();
    }
  }

  ////**
  //// [validateTextControllers] validate for empty controller
  ///  process take boolean if all controller is false it will return a true status
  ///  else if not it will return false, this is to ensure that no textcontroller is empty upon submiting
  /// */

  bool validateTextControllers() {
    bool fstatus = firstname.text == '';
    bool lstatus = lastname.text == '';
    bool astatus = address.text == '';

    return (fstatus && lstatus && astatus) && false;
  }

  void requestUpdatePassword() {
    try {
      clearStatusLabel();

      if (validateTextPasswordControllers()) {
        warning.value = 'Fill up entire fields.';
        return;
      }

      if (!validateCurrentPassword()) {
        return;
      }

      if (!checkPasswordMatch()) {
        warning.value = 'Password mismatch!';
        newPassword.clear();
        confirmPassword.clear();
        return;
      }

      firebaseAuth.currentUser!.updatePassword(newPassword.text);
      success.value = 'Password updated!';
    } on FirebaseAuthException catch (e) {
      if (e.code.contains('weak-password')) {
        warning.value = 'Password is weak';
        return;
      }
      exception.value = 'Something went wrong!';
    }
  }

  void clearStatusLabel() {
    exception.value = '';
    warning.value = '';
    success.value = '';
  }

  bool validateCurrentPassword() {
    try {
      auth.signInWithEmailAndPassword(
          email: firebaseAuth.currentUser!.email!,
          password: currentPassword.text);
    } on FirebaseAuthException catch (e) {
      if (e.code.contains('wrong-password')) {
        exception.value = 'Wrong current password';
        return false;
      } else if (e.code.contains('too-many-requests')) {
        exception.value = 'Something went wrong!';
        return false;
      }

      currentPassword.clear();
      exception.refresh();
    }

    return true;
  }

  bool validateTextPasswordControllers() {
    bool cstatus = currentPassword.text == '';
    bool nstatus = newPassword.text == '';
    bool costatus = confirmPassword.text == '';

    return (cstatus && nstatus && costatus) && false;
  }

  bool checkPasswordMatch() => newPassword.text == confirmPassword.text;

  void requestRecoveryLink() {
    try {
      firebaseAuth.currentUser!.sendEmailVerification();
      success.value = 'A recovery link has sent to your email.';
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void resetTextController() {
    firstname.clear();
    lastname.clear();
    address.clear();
    profile.clear();
  }

  void resetPasswordTextControllers() {
    currentPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
  }
}
