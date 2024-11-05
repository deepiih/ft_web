import 'package:sectar_web/package/config_packages.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> emailAddressController = TextEditingController().obs;
  RxBool isLoading = false.obs;

  Future<void> sendOtp({required BuildContext context, required String userType, email}) async {
    showAnimationToast(
      context: context,
      isForError: false,
      msg: "OTP sent successfully!",
    );
    GoRouter.of(context).replaceNamed(
      GoRouterNamed.otp,
      queryParameters: {
        Param.email: emailAddressController.value.text.trim(),
        Param.user: userType,
      },
    );
  }
}
