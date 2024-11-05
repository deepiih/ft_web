import 'package:sectar_web/package/config_packages.dart';

class NoProjectOrFreelancerWidget extends StatelessWidget {
  const NoProjectOrFreelancerWidget(
      {super.key,
      this.onTap,
      this.isClient,
      required this.title,
      required this.subTitle,
      required this.buttonText,
      required this.title1,
      required this.subTitle1});

  final Function()? onTap;
  final bool? isClient;
  final String title, subTitle, buttonText, title1, subTitle1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(MediaQuery.of(context).size.height / 10),
          Image.asset(
            AppImage.noProject,
            height: 26,
          ),
          const Gap(24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle()
                .normal20w400
                .textColor(AppColor.lightBlackColor),
          ),
          const Gap(8),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle()
                .normal16w400
                .textColor(AppColor.textSecondaryColor),
          ),
          Visibility(
            visible: false,
            child: Column(
              children: [
                const Gap(24),
                CommonAppButton(
                  onTap: onTap,
                  buttonType: ButtonType.enable,
                  text: buttonText,
                  width: 150,
                ),
                const Gap(50),
                Text(
                  title1,
                  textAlign: TextAlign.center,
                  style: const TextStyle()
                      .normal16w400
                      .textColor(AppColor.textSecondaryColor),
                ),
                const Gap(8),
                Text(
                  subTitle1,
                  textAlign: TextAlign.center,
                  style: const TextStyle()
                      .normal16w400
                      .textColor(AppColor.lightBlackColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
