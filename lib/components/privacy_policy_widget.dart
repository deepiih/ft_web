import 'package:sectar_web/package/config_packages.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  State<PrivacyPolicyWidget> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: CommonString.bySigningUpYouAgreeToOur,
            style: const TextStyle()
                .normal16w400
                .textColor(AppColor.lightGreyColor),
          ),
          TextSpan(
            text: ' ${CommonString.termAndCondition} ',
            style:
                const TextStyle().normal16w400.textColor(AppColor.primaryColor),
          ),
          TextSpan(
            text: '${CommonString.and} ',
            style: const TextStyle()
                .normal16w400
                .textColor(AppColor.lightGreyColor),
          ),
          TextSpan(
            text: ' ${CommonString.privacyPolicy} ',
            style:
                const TextStyle().normal16w400.textColor(AppColor.primaryColor),
          ),
        ],
      ),
    );
  }
}
