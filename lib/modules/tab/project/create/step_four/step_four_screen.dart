import 'package:go_router/go_router.dart';
import 'package:sectar_web/components/input_field.dart';
import 'package:sectar_web/modules/tab/project/create/step_four/step_four_controller.dart';
import 'package:sectar_web/modules/tab/project/create/step_one/step_one_controller.dart';
import 'package:sectar_web/utils/extension/uperCaseTextFormatter.dart';

import '../../../../../../package/config_packages.dart';

class StepFourScreen extends StatefulWidget {
  StepFourScreen({super.key, this.projectId});

  final String? projectId;

  @override
  State<StepFourScreen> createState() => _StepFourScreenState();
}

class _StepFourScreenState extends State<StepFourScreen> {
  final stepFourController = Get.put<StepFourController>(StepFourController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      stepFourController.getProjectInfo(projectId: widget.projectId ?? "");
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<StepFourController>();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: AppColor.white,
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 44.0, right: Responsive.isDesktop(context)?100: 20, top: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Text(
                          //   CommonString.homeCreateNewProject,
                          //   style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                          // ),
                          const CloseTextButton(),
                        ],
                      ),
                    ),
                    const Gap(28),
                    Center(
                      child: SizedBox(
                        width: Responsive.isDesktop(context) ? MediaQuery
                            .of(context)
                            .size
                            .width / 3.5 : double.infinity,
                        child: Padding(
                          padding: Responsive.isMobile(context) ? const EdgeInsets.all(10.0) : EdgeInsets.zero,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Step 4 of 4",
                                  style: const TextStyle().normal14w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(16),
                                Text(
                                  "Add client details",
                                  style: const TextStyle().normal24w700.textColor(AppColor.lightBlackColor),
                                ),
                                const Gap(16),
                                Text(
                                  "We will send the project for review and funding to the email you specify here",
                                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(36),
                                Text(
                                  "CLIENT NAME",
                                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(12),
                                InputField(
                                  inputFormatter: [FirstLetterCapitalFormatter()],
                                  controller: stepFourController.clientNameController.value,
                                  hint: 'Enter client name',
                                  validator: (val) {
                                    if (stepFourController.clientNameController.value.text.isEmpty) {
                                      return "Client name can't be empty";
                                    }
                                  },
                                ),
                                const Gap(24),
                                Text(
                                  "EMAIL address",
                                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(12),
                                InputField(
                                  validator: (val) {
                                    if (stepFourController.clientEmailController.value.text.isEmpty) {
                                      return "Client email can't be empty";
                                    } else if (!(stepFourController.clientEmailController.value.text.isEmail)) {
                                      return "Please enter valid email address";
                                    }
                                  },
                                  controller: stepFourController.clientEmailController.value,
                                  hint: 'Enter client’s email',
                                  keyboardType: TextInputType.emailAddress,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Image.asset(
                                      AppImage.mail,
                                      height: 20,
                                      width: 20,
                                      color: AppColor.textSecondaryColor,
                                    ),
                                  ),
                                ),
                                const Gap(44),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Expanded(
                                      flex: 1,
                                      child: SizedBox(),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: CommonBackButton(
                                        text: 'Back',
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    const Gap(15),
                                    Expanded(
                                      flex: 2,
                                      child: Obx(
                                            () =>
                                            CommonAppButton(
                                              onTap: () {
                                                if (_formKey.currentState!.validate()) {
                                                  stepFourController.addProjectClientApi(
                                                    context: context,
                                                    projectId: widget.projectId ?? "",
                                                    clientEmail: stepFourController.clientEmailController.value.text.trim(),
                                                    clientName: stepFourController.clientNameController.value.text,
                                                  );
                                                }
                                              },
                                              text: "Finish & review",
                                              buttonType: stepFourController.isLoading.value ? ButtonType.progress : ButtonType.enable,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(44),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (stepFourController.isGetProjectLoading.value) Center(child: showLoadingDialog()),

        ],
      );
    });
  }
}
