import 'package:sectar_web/package/config_packages.dart';

class ProjectLiveScreen extends StatelessWidget {
  const ProjectLiveScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AppImage.right,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: AppColor.successStatusColor,
              ),
            ),
            const Gap(15),
            Center(
              child: Text(
                "Payment successful. Congrats",
                textAlign: TextAlign.center,
                style: const TextStyle().normal20w600.textColor(AppColor.lightBlackColor),
              ),
            ),
            const Gap(16),
            Center(
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "We wish you happy and productive work\nwith this project. For any queries, please\nwrite to us as",
                      style: const TextStyle().normal18w400.textColor(AppColor.textSecondaryColor),
                    ),
                    TextSpan(
                      text: "support.sectar.co",
                      style: const TextStyle().normal18w400.textColor(AppColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(26),
            Center(
              child: CommonAppButton(
                width: 150,
                onTap: () {
                  launchUrl(
                    Uri.parse(
                       "https://demo.sectar.co/",
                    ),
                  );
                },
                buttonColor: AppColor.successStatusColor,
                isAddButton: true,
                buttonType: ButtonType.enable,
                text: 'Okay, thanks',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
