import 'package:sectar_web/package/config_packages.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    super.key,
    this.onCloseTap,
    this.title,
    this.content1,
    this.titleTextStyle,
    this.content1TextStyle,
    this.leftSideIcon,
    this.buttonFlex,
    this.buttonTap,
    this.buttonText,
    this.buttonColor,
    this.leftSideIconColor,
    this.isViewCenter,
    this.content2,
    this.content2TextStyle,
    required this.buttonType,
  });

  final Function()? onCloseTap, buttonTap;
  final String? title, content1, content2, leftSideIcon, buttonText;
  final TextStyle? titleTextStyle, content1TextStyle, content2TextStyle;
  final int? buttonFlex;
  final Color? buttonColor, leftSideIconColor;
  final bool? isViewCenter;
  final ButtonType? buttonType;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: false,
      ),
      child: SimpleDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        backgroundColor: AppColor.white,
        title: Column(
          crossAxisAlignment: isViewCenter ?? false ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            isViewCenter ?? false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        leftSideIcon ?? "",
                        height: 24,
                        width: 24,
                        fit: BoxFit.cover,
                        color: leftSideIconColor ?? AppColor.textSecondaryColor,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        leftSideIcon ?? "",
                        height: 24,
                        width: 24,
                        fit: BoxFit.cover,
                        color: leftSideIconColor ?? AppColor.textSecondaryColor,
                      ),
                      const CloseTextButton(),
                    ],
                  ),
            const Gap(24),
            Column(
              crossAxisAlignment: isViewCenter ?? false ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "",
                  textAlign: isViewCenter ?? false ? TextAlign.center : TextAlign.start,
                  style: titleTextStyle ?? const TextStyle().normal20w600.textColor(AppColor.lightBlackColor),
                ),
                if ((content1?.isNotEmpty ?? false) || (content2?.isNotEmpty ?? false))
                  Column(
                    children: [
                      const Gap(16),
                      Text.rich(
                        textAlign: isViewCenter ?? false ? TextAlign.center : TextAlign.start,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: content1 ?? "",
                              style: content1TextStyle ?? const TextStyle().normal18w400.textColor(AppColor.textSecondaryColor),
                            ),
                            TextSpan(
                              text: content2 ?? "",
                              style: content2TextStyle ?? const TextStyle().normal18w400.textColor(AppColor.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ],
            ),
            const Gap(24),
            Row(
              children: [
                Expanded(
                  flex: (isViewCenter ?? false) ? 2 : 0,
                  child: const SizedBox(),
                ),
                Expanded(
                  flex: buttonFlex ?? 5,
                  child: CommonAppButton(
                    onTap: buttonTap ?? () {},
                    buttonColor: buttonColor ?? AppColor.primaryColor,
                    isAddButton: true,
                    buttonType: buttonType ?? ButtonType.enable,
                    text: buttonText ?? '',
                  ),
                ),

                const Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
