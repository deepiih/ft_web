import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

class StepTwoScreen extends StatefulWidget {
  const StepTwoScreen({
    super.key,
    this.isFirstMilestone = "1",
    this.projectId,
    this.milestoneId,
  });

  final String? projectId;
  final String? milestoneId;
  final String? isFirstMilestone;

  @override
  State<StepTwoScreen> createState() => _StepTwoScreenState();
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  final stepTwoController = Get.put<StepTwoController>(StepTwoController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isFirstMilestone == "1") {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        stepTwoController.getProjectInfo(projectId: widget.projectId ?? "");
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<StepTwoController>();
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 44.0, right: Responsive.isDesktop(context) ? 100 : 20, top: 32),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CloseTextButton(),
                          ],
                        ),
                      ),
                      const Gap(28),
                      Center(
                        child: SizedBox(
                          width: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width / 3.5 : double.infinity,
                          child: Padding(
                            padding: Responsive.isMobile(context) ? const EdgeInsets.all(20.0) : EdgeInsets.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: (widget.isFirstMilestone == "1"),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        CommonString.step2Of3,
                                        style: const TextStyle().normal14w400.textColor(AppColor.textSecondaryColor),
                                      ),
                                      const Gap(16),
                                    ],
                                  ),
                                ),
                                Text(
                                  widget.isFirstMilestone == "0" ? "New milestone" : CommonString.firstMilestone,
                                  style: const TextStyle().normal24w700.textColor(AppColor.lightBlackColor),
                                ),
                                const Gap(16),
                                Text(
                                  widget.isFirstMilestone == "0" ? "Enter the new milestone details" : CommonString.kickstartProject,
                                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(36),
                                Text(
                                  CommonString.mileStoneName,
                                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(12),
                                Obx(
                                  () => InputField(
                                    inputFormatter: [FirstLetterCapitalFormatter()],
                                    controller: stepTwoController.mileStoneNameController.value,
                                    hint: CommonString.hintResearchDiscovery,
                                    validator: (val) {
                                      if (stepTwoController.mileStoneNameController.value.text.isEmpty) {
                                        return "Milestone name can't be empty";
                                      }
                                    },
                                  ),
                                ),
                                const Gap(32),
                                Text(
                                  CommonString.firstMileStoneBudget,
                                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(12),
                                InputField(
                                  validator: (val) {
                                    if (stepTwoController.firstMileStoneBudgetController.value.text.isEmpty) {
                                      return "Milestone budget can't be empty";
                                    }
                                  },
                                  inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                                  controller: stepTwoController.firstMileStoneBudgetController.value,
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
                                ),
                                if (widget.isFirstMilestone == "1") const Gap(12),
                                if (widget.isFirstMilestone == "1")
                                  Text(
                                    CommonString.clientFundKickstartProject,
                                    style: const TextStyle().normal14w400.textColor(AppColor.textSecondaryColor),
                                  ),
                                const Gap(32),
                                Text(
                                  CommonString.tentativeStartDate,
                                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(12),
                                InputField(
                                  validator: (val) {
                                    if (stepTwoController.startDateController.value.text.isEmpty) {
                                      return CommonString.plsSelectStartDate;
                                    }
                                  },
                                  readOnly: true,
                                  onTap: () async {
                                    if (await CommonDatePicker.selectDate(context) != null) {
                                      stepTwoController.selectedStartDate = await CommonDatePicker.selectDate(context) ?? DateTime.now();
                                      String formattedDate = DateFormat(CommonDateFormat.E_d_MMMM_y).format(stepTwoController.selectedStartDate);
                                      stepTwoController.startDateController.value.text = formattedDate;
                                    }
                                  },
                                  controller: stepTwoController.startDateController.value,
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
                                ),
                                const Gap(18),
                                Text(
                                  CommonString.tentativeEndDate,
                                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(12),
                                InputField(
                                  validator: (val) {
                                    if (stepTwoController.endDateController.value.text.isEmpty) {
                                      return CommonString.plsSelectEndDate;
                                    }
                                  },
                                  readOnly: true,
                                  onTap: () async {
                                    if (await CommonDatePicker.selectDate(context) != null) {
                                      stepTwoController.selectedEndDate = await CommonDatePicker.selectDate(context) ?? DateTime.now();
                                      String formattedDate = DateFormat(CommonDateFormat.E_d_MMMM_y).format(stepTwoController.selectedEndDate);
                                      stepTwoController.endDateController.value.text = formattedDate;
                                    }
                                  },
                                  controller: stepTwoController.endDateController.value,
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
                                ),
                                const Gap(32),
                                Text(
                                  CommonString.description,
                                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(12),
                                InputField(
                                  inputFormatter: [FirstLetterCapitalFormatter()],
                                  controller: stepTwoController.descriptionController.value,
                                  hint: CommonString.describeMileStoneBriefly,
                                  maxLine: 4,
                                ),
                                const Gap(32),
                                Text(
                                  CommonString.specifyDeliverables,
                                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(8),
                                Text(
                                  CommonString.deliverInMileStone,
                                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(16),
                                Obx(
                                  () => ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InputField(
                                        validator: (val) {
                                          if (stepTwoController.deliverableControllerList[index].text.isEmpty) {
                                            return "Milestone deliverable can't be empty";
                                          }
                                        },
                                        inputFormatter: [FirstLetterCapitalFormatter()],
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              stepTwoController.deliverableControllerList.removeAt(index);
                                            },
                                            child: Image.asset(
                                              AppImage.close,
                                              height: 20,
                                              width: 20,
                                              color: AppColor.errorStatusColor,
                                            ),
                                          ),
                                        ),
                                        controller: stepTwoController.deliverableControllerList[index],
                                        hint: CommonString.addDeliverable,
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 5,
                                      );
                                    },
                                    itemCount: stepTwoController.deliverableControllerList.length,
                                  ),
                                ),
                                const Gap(10),
                                GestureDetector(
                                  onTap: () {
                                    stepTwoController.deliverableControllerList.add(TextEditingController());
                                  },
                                  child: Text(
                                    CommonString.addMore,
                                    style: const TextStyle().normal16w400.textColor(AppColor.primaryColor),
                                  ),
                                ),
                                const Gap(32),
                                Text(
                                  CommonString.attachFiles,
                                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(12),
                                Obx(
                                  () => ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InputField(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Image.asset(
                                            AppImage.uploadFile,
                                            height: 18,
                                            width: 18,
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                        readOnly: true,
                                        onTap: () async {
                                          if ((stepTwoController.projectInfo.value?.project?.first.milestone ?? []).isNotEmpty &&
                                              stepTwoController.uploadFileList[index].fileName != null &&
                                              stepTwoController.uploadFileList[index].fileName!.isNotEmpty) {
                                            launchUrl(
                                              Uri.parse(
                                                stepTwoController.uploadFileList[index].fileName ?? "",
                                              ),
                                            );
                                          } else {
                                            await stepTwoController.selectPdfFile(index);
                                          }
                                        },
                                        validator: (val) {},
                                        inputFormatter: [FirstLetterCapitalFormatter()],
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              stepTwoController.uploadFileList.removeAt(index);
                                            },
                                            child: Image.asset(
                                              AppImage.close,
                                              height: 20,
                                              width: 20,
                                              color: AppColor.errorStatusColor,
                                            ),
                                          ),
                                        ),
                                        controller: TextEditingController(text: basename(stepTwoController.uploadFileList[index].fileName ?? "")),
                                        hint: CommonString.uploadFile,
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 5,
                                      );
                                    },
                                    itemCount: stepTwoController.uploadFileList.length,
                                  ),
                                ),
                                const Gap(12),
                                Text(
                                  CommonString.maxFiveMB,
                                  style: const TextStyle().normal14w400.textColor(AppColor.textSecondaryColor),
                                ),
                                const Gap(20),
                                GestureDetector(
                                  onTap: () {
                                    stepTwoController.uploadFileList.add(UploadFileModel(file: XFile(""), fileName: ""));
                                  },
                                  child: Text(
                                    CommonString.addMore,
                                    style: const TextStyle().normal16w400.textColor(AppColor.primaryColor),
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
                                        text: CommonString.back,
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
                                          onTap: () async {
                                            if (_formKey.currentState!.validate()) {
                                              await stepTwoController.createMileStone(
                                                isFromAddMileStone: widget.isFirstMilestone == "0",
                                                context: context,
                                                projectId: widget.projectId ?? "",
                                                isFirstMilestone: widget.isFirstMilestone == "0" ? "0" : "1",
                                                mileStoneId: (stepTwoController.projectInfo.value?.project?.first.milestone ?? []).isNotEmpty
                                                    ? stepTwoController.projectInfo.value?.project?.first.milestone?.first.id.toString() ?? ""
                                                    : "",
                                                milestoneName: stepTwoController.mileStoneNameController.value.text,
                                                milestoneBudget: stepTwoController.firstMileStoneBudgetController.value.text,
                                                startDate: DateFormat(CommonDateFormat.E_d_MMMM_y).format(stepTwoController.selectedStartDate),
                                                endDate: DateFormat(CommonDateFormat.E_d_MMMM_y).format(stepTwoController.selectedEndDate),
                                                deliverableList: stepTwoController.deliverableControllerList,
                                                description: stepTwoController.descriptionController.value.text,
                                              );
                                            }
                                          },
                                          text: widget.isFirstMilestone == "0" ? "Send for review" : CommonString.okayNext,
                                          buttonType: stepTwoController.isLoading.value ? ButtonType.progress : ButtonType.enable,
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
          ),
          if (stepTwoController.isGetProjectLoading.value) Center(child: showLoadingDialog()),
        ],
      );
    });
  }
}
