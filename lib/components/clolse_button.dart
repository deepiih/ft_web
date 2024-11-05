import 'package:sectar_web/package/config_packages.dart';

class CloseTextButton extends StatelessWidget {
  const CloseTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
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
            CommonString.close,
            style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
          ),
        ],
      ),
    );
  }
}
