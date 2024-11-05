import 'package:sectar_web/package/config_packages.dart';

void showAppToast(String? msg) {
  if (msg == null || msg.isEmpty) {
    return;
  }
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showErrorToast(String? msg) {
  if (msg == null || msg.isEmpty) {
    return;
  }
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: AppColor.errorStatusColor,
    textColor: AppColor.white,
    fontSize: 14,
    gravity: ToastGravity.BOTTOM,
  );
}

void showAnimationToast({
  required BuildContext context,
  String? msg,
  bool? isForError,
}) {
  showToast(msg??"", isForError ?? false ? AppImage.information : AppImage.right,
      context: context,
      imageColor: isForError ?? false ?AppColor.errorStatusColor:AppColor.successStatusColor,
      imageHeight: 20,
      imageWidth: 20,
      backgroundColor: AppColor.white,
      animation: StyledToastAnimation.slideFromRightFade,
      reverseAnimation: StyledToastAnimation.slideToRightFade,
      toastHorizontalMargin: 50,
      position: const StyledToastPosition(align: Alignment.topRight, offset: 20.0),
      startOffset: const Offset(1.0, 0.0),
      reverseEndOffset: const Offset(1.0, 0.0),
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      fullWidth: false,
      textAlign: TextAlign.start,
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.fastOutSlowIn);
}
