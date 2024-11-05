import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.onPressed, this.userType = CommonString.freelancer});

  final Function(String)? onPressed;
  final String userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put<LoginController>(LoginController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Center(
          child: SizedBox(
            width: Responsive.isDesktop(context) ? 400 : double.infinity,
            child: SingleChildScrollView(
              padding: Responsive.isMobile(context) ? const EdgeInsets.all(20.0) : EdgeInsets.zero,
              child: _buildLoginWidget(context),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildLoginWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(
                color: AppColor.lightBlackColor,
                Icons.energy_savings_leaf_sharp,
              ),
            ),
            Text(
              "STRIVEBOARD",
              style: const TextStyle().normal24w700.textColor(AppColor.lightBlackColor),

            ),
          ],
        ),
        const Gap(40),
        Text(
          widget.userType == CommonString.client ? CommonString.getStartedAsClient : CommonString.getStartedAsFreelancer,
          style: const TextStyle().normal24w700.textColor(AppColor.lightBlackColor),
        ),
        const Gap(16),
        Text(
          CommonString.enterEmailAddressToContinue,
          style: const TextStyle().normal18w400.textColor(AppColor.lightGreyColor),
        ),
        const Gap(32),
        Text(
          CommonString.emailAddress,
          style: const TextStyle().normal16w400.textColor(AppColor.lightGreyColor),
        ),
        const Gap(12),
        Form(
          key: _formKey,
          child: InputField(
            onSubmitted: (val) {
              if (_formKey.currentState!.validate()) {
                loginController.sendOtp(context: context, userType: widget.userType, email: val?.trim());
              }
            },
            keyboardType: TextInputType.emailAddress,
            hint: CommonString.enterYourEmail,
            fillColor: AppColor.white,
            validator: (val) {
              if (loginController.emailAddressController.value.text.isEmpty) {
                return CommonString.emailCanNotEmpty;
              } else if (!(loginController.emailAddressController.value.text.isEmail)) {
                return CommonString.plsEnterValidEmailAddress;
              }
            },
            controller: loginController.emailAddressController.value,
          ),
        ),
        const Gap(8),
        Obx(
          () => CommonAppButton(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                await loginController.sendOtp(
                  context: context,
                  userType: widget.userType,
                  email: loginController.emailAddressController.value.text.trim(),
                );
              }
            },
            text: CommonString.continueText,
            buttonType: loginController.isLoading.value ? ButtonType.progress : ButtonType.enable,
          ),
        ),
        const Gap(24),
        const PrivacyPolicyWidget(),
        const Gap(70),
        Center(
          child: GestureDetector(
            onTap: () {
              if (widget.userType == CommonString.client) {
                GoRouter.of(context).replaceNamed(GoRouterNamed.login, queryParameters: {Param.user: CommonString.freelancer});
              } else {
                GoRouter.of(context).replaceNamed(GoRouterNamed.login, queryParameters: {Param.user: CommonString.client});
              }
            },
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: widget.userType == CommonString.client ? CommonString.areYouFreelancer : CommonString.areYouClient,
                    style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                  ),
                  TextSpan(
                    text: ' ${CommonString.loginHere}',
                    style: const TextStyle().normal18w400.textColor(AppColor.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
