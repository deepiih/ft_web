import 'package:sectar_web/package/config_packages.dart';

class TitleSubTitleWidget extends StatelessWidget {
  const TitleSubTitleWidget({
    super.key,
    this.text1,
    this.text2,
    this.textStyle1,
    this.textStyle2,
    this.titleChildWidget,
  });

  final String? text1, text2;
  final TextStyle? textStyle1, textStyle2;
  final Widget? titleChildWidget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                text1 ?? "",
                style: textStyle1 ??
                    (Responsive.isMobile(context) ? const TextStyle().normal20w700.textColor(AppColor.lightBlackColor) : const TextStyle().normal24w700.textColor(AppColor.lightBlackColor)),
              ),
              Expanded(
                flex: Responsive.isDesktop(context) ? 3 : 2,
                child: titleChildWidget ?? const Text(""),
              ),
            ],
          ),
          Text(
            text2 ?? "",
            style: textStyle2 ?? const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
          ),
        ],
      ),
    );
  }
}
