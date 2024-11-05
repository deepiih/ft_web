
import 'package:sectar_web/package/config_packages.dart';

class DeleteProjectDialog extends StatelessWidget {
  const DeleteProjectDialog({super.key, required this.onTap, required this.buttonType, this.title, this.subTitle, this.buttonText});

  final Function()? onTap;
  final ButtonType buttonType;

  final String? title, subTitle, buttonText;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AppImage.delete,
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        AppImage.close,
                        height: 20,
                        width: 20,
                        color: AppColor.errorStatusColor,
                      ),
                      const Gap(8),
                      Text(
                        "Close",
                        style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Gap(24),
            Text(
              title ?? "Delete project?",
              style: const TextStyle().normal20w600.textColor(AppColor.lightBlackColor),
            ),
            const Gap(16),
            Text(
              subTitle ?? "Are you sure you want to delete this\nproject? This can’t be undone.",
              style: const TextStyle().normal18w400.textColor(AppColor.textSecondaryColor),
            ),
            const Gap(24),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: CommonAppButton(
                    onTap: onTap,
                    buttonType: buttonType,
                    text: buttonText??'Delete project',
                    isAddButton: true,
                    buttonColor: AppColor.errorStatusColor,
                  ),
                ),
                const Expanded(
                  flex: 5,
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
