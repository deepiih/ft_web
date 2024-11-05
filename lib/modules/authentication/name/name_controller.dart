import 'package:sectar_web/package/config_packages.dart';

class NameController extends GetxController {
  Rx<TextEditingController> nameFieldController = TextEditingController().obs;
  RxBool isLoading = false.obs;

  Future<void> updateProfile({required BuildContext context, required String name}) async {
    showAnimationToast(
      context: context,
      isForError: false,
      msg: "Account created successfully!",
    );
    AppPref().name = name;
    AppPref().email = "demo@gmail.com";
    AppPref().token = "token";

    AppPref().userType = 1;
    if (context.mounted) {
      if (AppPref().userType == 2) {
        GoRouter.of(context).replaceNamed(GoRouterNamed.project);
      } else {
        GoRouter.of(context).replaceNamed(GoRouterNamed.dashboard);
      }
    }
  }
}
