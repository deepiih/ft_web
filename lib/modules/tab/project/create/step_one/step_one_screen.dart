import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

class StepOneScreen extends StatefulWidget {
  const StepOneScreen({
    super.key,
    this.projectId,
  });

  final String? projectId;

  @override
  State<StepOneScreen> createState() => _StepOneScreenState();
}

class _StepOneScreenState extends State<StepOneScreen> {
  final stepOneController = Get.put<StepOneController>(StepOneController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    Get.delete<StepOneController>();
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
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                     Padding(
                      padding: EdgeInsets.only(left: 44.0, right:Responsive.isDesktop(context)?100: 20, top: 32),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          CloseTextButton(),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Center(
                      child: SizedBox(
                        width: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width / 3.5 : double.infinity,
                        child: Padding(
                          padding: Responsive.isMobile(context) ? const EdgeInsets.all(20.0) : EdgeInsets.zero,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                CommonString.step1Of3,
                                style: const TextStyle().normal14w400.textColor(AppColor.textSecondaryColor),
                              ),
                              const Gap(16),
                              Text(
                                CommonString.projectBio,
                                style: const TextStyle().normal24w700.textColor(AppColor.lightBlackColor),
                              ),
                              const Gap(32),
                              Text(
                                CommonString.projectName,
                                style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                              ),
                              const Gap(12),
                              InputField(
                                inputFormatter: [FirstLetterCapitalFormatter()],
                                // firstCapital: true,
                                controller: stepOneController.projectNameController.value,
                                hint: CommonString.enterProjectName,
                                validator: (val) {
                                  if (stepOneController.projectNameController.value.text.isEmpty) {
                                    return CommonString.projectNameCanNotEmpty;
                                  }
                                },
                              ),
                              const Gap(24),
                              Text(
                                CommonString.estimatedProjectBudget,
                                style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                              ),
                              const Gap(12),
                              InputField(
                                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                                controller: stepOneController.projectBudgetController.value,
                                hint: CommonString.specifyBudget,
                                keyboardType: TextInputType.number,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset(
                                    AppImage.dollar1,
                                    height: 18,
                                    width: 18,
                                    color: AppColor.textSecondaryColor,
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset(
                                    AppImage.dollar,
                                    height: 20,
                                    width: 20,
                                    color: AppColor.textSecondaryColor,
                                  ),
                                ),
                                validator: (val) {
                                  if (stepOneController.projectBudgetController.value.text.isEmpty) {
                                    return CommonString.projectBudgetCanNotEmpty;
                                  }
                                },
                              ),
                              const Gap(15),
                              Text(
                                CommonString.ballparkNumberChangeLater,
                                style: const TextStyle().normal14w400.textColor(AppColor.lightGreyColor),
                              ),
                              const Gap(24),
                              Text(
                                CommonString.tentativeStartDate,
                                style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                              ),
                              const Gap(12),
                              InputField(
                                onTap: () async {
                                  stepOneController.selectedDate = await CommonDatePicker.selectDate(context) ?? DateTime.now();
                                  String formattedDate = DateFormat(CommonDateFormat.E_d_MMMM_y).format(stepOneController.selectedDate);
                                  stepOneController.startDateController.value.text = formattedDate;
                                },
                                readOnly: true,
                                controller: stepOneController.startDateController.value,
                                hint: CommonString.selectDate,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset(
                                    AppImage.calendar,
                                    height: 20,
                                    width: 20,
                                    color: AppColor.textSecondaryColor,
                                  ),
                                ),
                                validator: (val) {
                                  if (stepOneController.startDateController.value.text.isEmpty) {
                                    return CommonString.plsSelectStartDate;
                                  }
                                },
                              ),
                              const Gap(15),
                              Text(
                                CommonString.estimate,
                                style: const TextStyle().normal14w400.textColor(AppColor.lightGreyColor),
                              ),
                              const Gap(32),
                              Obx(
                                () => CommonAppButton(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      stepOneController.createProject(
                                        projectId: stepOneController.projectInfo.value?.project?.first.id.toString() ?? "",
                                        context: context,
                                        projectName: stepOneController.projectNameController.value.text.trim(),
                                        projectBudget: stepOneController.projectBudgetController.value.text.trim(),
                                        startDate: DateFormat(CommonDateFormat.E_d_MMMM_y).format(stepOneController.selectedDate),
                                      );
                                    }
                                  },
                                  text: CommonString.continueText,
                                  buttonType: stepOneController.isLoading.value ? ButtonType.progress : ButtonType.enable,
                                ),
                              ),
                              const Gap(32),
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
          if (stepOneController.isGetProjectLoading.value) Center(child: showLoadingDialog()),
        ],
      );
    });
  }
}
