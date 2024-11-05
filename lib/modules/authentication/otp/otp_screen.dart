import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email, required this.userType});

  final String? email;
  final String? userType;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = Get.put<OtpController>(OtpController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController otpFieldController = TextEditingController();

  @override
  void dispose() {
    Get.delete<OtpController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Center(
          child: SizedBox(
            width: Responsive.isDesktop(context) ? 400 : double.infinity,
            child: Padding(
              padding: Responsive.isMobile(context)
                  ? const EdgeInsets.all(20.0)
                  : EdgeInsets.zero,
              child: _buildOtpWidget(context),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildOtpWidget(BuildContext context) {
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
          CommonString.sentCodeOnEmail,
          style: const TextStyle()
              .normal24w700
              .textColor(AppColor.lightBlackColor),
        ),
        const Gap(16),
        Text(
          CommonString.plsEnterCodeToContinue,
          style:
              const TextStyle().normal18w400.textColor(AppColor.lightGreyColor),
        ),
        const Gap(32),
        Form(
          key: _formKey,
          child: PinCodeTextField(
            controller: otpFieldController,
            appContext: context,
            length: 6,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
            ],
            hintCharacter: "-",
            hintStyle: const TextStyle(color: AppColor.backgroundStokeColor),
            textStyle: const TextStyle()
                .normal18w400
                .textColor(AppColor.lightBlackColor),
            blinkWhenObscuring: true,
            animationType: AnimationType.fade,
            validator: (v) {
              if (v!.length < 6) {
                return CommonString.plsEnterValidOtp;
              } else {
                return null;
              }
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              borderWidth: 0.5,
              fieldHeight: Responsive.isDesktop(context) ? 47 : 47,
              fieldWidth: Responsive.isDesktop(context) ? 47 : 47,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
              activeColor: AppColor.backgroundStokeColor,
              inactiveColor: AppColor.backgroundStokeColor,
              selectedColor: AppColor.primaryColor,
            ),
            useHapticFeedback: true,
            cursorColor: AppColor.primaryColor,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            onCompleted: (v) {},
            onChanged: (v) {
              debugPrint(v);
            },
          ),
        ),
        const Gap(32),
        Obx(
          () => CommonAppButton(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                otpController.verifyOtp(
                  context: context,
                  email: widget.email ?? "",
                  otp: otpFieldController.text,
                  userType: widget.userType ?? "",
                );
              }
            },
            text: CommonString.verifyCode,
            buttonType: otpController.isLoading.value
                ? ButtonType.progress
                : ButtonType.enable,
          ),
        ),
        const Gap(24),
        Obx(
          () => Column(
            children: [
              if (otpController.isResend.value) ...[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Responsive.isMobile(context) ? 90 : 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Countdown(
                        seconds: 30,
                        build: (BuildContext context, double time) {
                          Duration duration = Duration(seconds: time.toInt());

                          String formattedTime =
                              '${duration.inMinutes.remainder(60).toString().padLeft(1, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}';

                          return Text(
                            formattedTime,
                            style: const TextStyle().normal16w700.textColor(
                                  AppColor.primaryColor,
                                ),
                          );
                        },
                        interval: const Duration(seconds: 1),
                        onFinished: () {
                          otpController.isResend.value = false;
                        },
                      ),
                      Text(
                        " ${CommonString.second}",
                        style: const TextStyle().normal16w700.textColor(
                              AppColor.primaryColor,
                            ),
                      ),
                    ],
                  ),
                )
              ] else ...[
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Responsive.isMobile(context)
                            ? MediaQuery.of(context).size.width / 4
                            : 50.0),
                    child: InkWell(
                      onTap: () {
                        otpController.isResend.value = true;
                        otpController.reSendOtp(
                          context: context,
                          email: widget.email ?? "",
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.refresh,
                            size: 20,
                            color: AppColor.textSecondaryColor,
                          ),
                          const Gap(8),
                          Text(
                            CommonString.resendCode,
                            style: const TextStyle()
                                .normal16w400
                                .textColor(AppColor.textSecondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
