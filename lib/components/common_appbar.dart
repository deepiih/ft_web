import 'package:sectar_web/package/config_packages.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final TextStyle? textStyle;
  final bool deleteIcon;
  final Callback? onTap;
  final Callback? reloadOnTap;

  const CommonAppBar({
    super.key,
    this.title,
    this.onTap,
    this.leading,
    this.reloadOnTap,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.deleteIcon = false,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading
          ? leading ??
              GestureDetector(
                onTap: onTap ??
                    () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pop(context);
                    },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColor.black,
                ),
              )
          : Container(),
      backgroundColor: AppColor.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColor.black, size: 24),
      centerTitle: true,
      titleTextStyle: textStyle ??
          const TextStyle(color: AppColor.primaryColor).normal18w500,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
