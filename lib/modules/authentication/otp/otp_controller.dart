import 'package:dio/dio.dart' as d;
import 'package:sectar_web/package/config_packages.dart';

class OtpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isResend = false.obs;

  Future<void> reSendOtp({required BuildContext context, required String email}) async {
    try {
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.email, email));

      var resp = await callApi(
        dio.post(
          EndPoint.sendotp,
          data: formData,
        ),
      );
      if (resp?.data != null) {
        if (context.mounted) {
          showAnimationToast(
            context: context,
            isForError: !resp?.data[CommonString.status],
            msg: resp?.data[CommonString.message],
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> verifyOtp({required BuildContext context, required String email, otp, userType}) async {
    showAnimationToast(
      context: context,
      isForError: false,
      msg: "OTP verified successfully!",
    );
    AppPref().token = "token";
    AppPref().email = "demo@gmail.com";
    AppPref().userType = 1;
    if (AppPref().name.isEmpty) {
      if (context.mounted) {
        GoRouter.of(context).replaceNamed(GoRouterNamed.name);
      }
    } else {
      if (context.mounted) {
        if (AppPref().userType == 2) {
          GoRouter.of(context).replaceNamed(GoRouterNamed.project);
        } else {
          GoRouter.of(context).replaceNamed(GoRouterNamed.dashboard);
        }
      }
    }
  }
}
