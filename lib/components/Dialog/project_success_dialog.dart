import 'package:sectar_web/package/config_packages.dart';

class ProjectSuccessDialog extends StatelessWidget {
  final String? titleText;
  final String? displayText;
  final String? buttonText;
  final String? image;
  final bool? isSuccess;
  final bool? isQuery;
  final Function()? onTap;

  const ProjectSuccessDialog(
      {super.key,
      this.titleText,
      this.displayText,
      this.buttonText,
      this.image,
      this.isSuccess = true,
      this.isQuery = true,
      this.onTap});

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
                  flex: 2,
                  child: CommonAppButton(
                    onTap: onTap,
                    buttonType: ButtonType.enable,
                    text: buttonText ?? "Done",
                  ),
                ),
                const Expanded(
                  flex: 4,
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


