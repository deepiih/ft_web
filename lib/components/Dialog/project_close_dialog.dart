import 'package:sectar_web/package/config_packages.dart';

class ProjectCloseDialog extends StatelessWidget {
  final String? titleText;
  final String? displayText;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final String? image;
  final bool? isSuccess;
  final bool? isQuery;
  final Function()? onTap;
  final ButtonType? buttonType;

  const ProjectCloseDialog({
    super.key,
    this.titleText,
    this.displayText,
    this.positiveButtonText,
    this.negativeButtonText,
    this.image,
    this.isSuccess = true,
    this.isQuery = true,
    this.onTap,
    this.buttonType,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: false,
      ),
      child: SimpleDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColor.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              isSuccess == true ? AppImage.right : AppImage.danger,
              height: 46,
              width: 48,
              fit: BoxFit.cover,
            ),
            const Gap(24),
            Text(
              titleText ?? "",
              style: const TextStyle()
                  .normal20w600
                  .textColor(AppColor.lightBlackColor),
            ),
            const Gap(16),
            Text(
              displayText ?? "",
              style: const TextStyle()
                  .normal18w400
                  .textColor(AppColor.lightBlackColor),
            ),
            const Gap(24),
            Text.rich(
              textAlign: TextAlign.start,
              TextSpan(
                children: [
                  TextSpan(
                    text: 'For any queries, please reach out to us at',
                    style: const TextStyle()
                        .normal16w400
                        .textColor(AppColor.lightGreyColor),
                  ),
                  TextSpan(
                    text: '\nsupport@sectar.co',
                    style: const TextStyle()
                        .normal16w400
                        .textColor(AppColor.primaryColor),
                  ),
                ],
              ),
            ),
            const Gap(24),
            Row(
              children: [
                Expanded(
                  child: CommonAppButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    buttonType: ButtonType.enable,
                    text: positiveButtonText ?? "Back",
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CommonAppButton(
                    isAddButton: true,
                    buttonColor: Colors.red,
                    buttonType: buttonType == ButtonType.progress
                        ? ButtonType.progress
                        : ButtonType.enable,
                    onTap: onTap,
                    text: negativeButtonText ?? "Done",
                  ),
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
