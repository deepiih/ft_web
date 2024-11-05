import 'package:sectar_web/modules/tab/project/create/step_three/step_three_controller.dart';

import '../../../../../../package/config_packages.dart';

class StepThreeScreen extends StatefulWidget {
  StepThreeScreen({super.key, this.projectId});

  final String? projectId;

  @override
  State<StepThreeScreen> createState() => _StepThreeScreenState();
}

class _StepThreeScreenState extends State<StepThreeScreen> {
  final stepThreeController = Get.put<StepThreeController>(StepThreeController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      stepThreeController.getProjectInfo(projectId: widget.projectId ?? "");
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<StepThreeController>();
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
                      padding: EdgeInsets.only(left: 44.0, right: Responsive.isDesktop(context) ? 100 : 20, top: 32),
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
                        width: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width / 3.5 : double.infinity,
                        child: Padding(
                          padding: Responsive.isMobile(context) ? const EdgeInsets.all(10.0) : EdgeInsets.zero,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Step 3 of 3",
                                style: const TextStyle().normal14w400.textColor(AppColor.textSecondaryColor),
                              ),
                              const Gap(16),
                              Text(
                                "Additional details",
                                style: const TextStyle().normal24w700.textColor(AppColor.lightBlackColor),
                              ),
                              const Gap(16),
                              Text(
                                "Use this space to give a heads up on the next milestones, plans or anything you feel important. ",
                                style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                              ),
                              const Gap(16),
                              Text.rich(
                                textAlign: TextAlign.start,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Here’s a sample for you : ',
                                      style: const TextStyle().normal16w400.textColor(AppColor.lightGreyColor),
                                    ),
                                    TextSpan(
                                      text: 'Project Notes',
                                      style: const TextStyle().normal16w400.textColor(AppColor.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(32),
                              Text(
                                "NOTES",
                                style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                              ),
                              const Gap(12),
                              Form(
                                key: _formKey,
                                child: InputField(
                                  height: 240,
                                  validator: (val) {
                                    if (stepThreeController.noteController.value.text.isEmpty) {
                                      return "Additional notes can't be empty";
                                    }
                                  },
                                  inputFormatter: [FirstLetterCapitalFormatter()],
                                  controller: stepThreeController.noteController.value,
                                  hint: 'Add additional notes for context & clarity',
                                  maxLine: 10,
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
                                  const Gap(16),
                                  Expanded(
                                    flex: 2,
                                    child: Obx(
                                      () => CommonAppButton(
                                        onTap: () {
                                          if (_formKey.currentState!.validate()) {
                                            stepThreeController.saveProjectNoteApi(
                                              context: context,
                                              note: stepThreeController.noteController.value.text.trim(),
                                              projectId: widget.projectId ?? "",
                                            );
                                          }
                                        },
                                        text: "Continue",
                                        buttonType: stepThreeController.isLoading.value ? ButtonType.progress : ButtonType.enable,
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
                  ],
                ),
              ),
            ),
          ),
          if (stepThreeController.isGetProjectLoading.value) Center(child: showLoadingDialog()),
        ],
      );
    });
  }
}
