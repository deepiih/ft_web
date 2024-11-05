import 'dart:convert';

import 'package:sectar_web/components/Dialog/add_note_dialog.dart';
import 'package:sectar_web/components/review_widget.dart';
import 'package:sectar_web/modules/tab/project/review_project/review_project_controller.dart';
import 'package:sectar_web/package/config_packages.dart';

class ReviewProjectScreen extends StatefulWidget {
  const ReviewProjectScreen({super.key, this.projectId});

  final String? projectId;

  @override
  State<ReviewProjectScreen> createState() => _ReviewProjectScreenState();
}

class _ReviewProjectScreenState extends State<ReviewProjectScreen> {
  final reviewProjectController =
      Get.put<ReviewProjectController>(ReviewProjectController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      reviewProjectController.getProjectInfo(projectId: widget.projectId ?? "");
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ReviewProjectController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 44.0,
                      right: Responsive.isDesktop(context) ? 100 : 20,
                      top: 32),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Text(
                      //   CommonString.homeCreateNewProject,
                      //   style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                      // ),
                      CloseTextButton(),
                    ],
                  ),
                ),
                const Gap(28),
                Center(
                  child: SizedBox(
                    width: Responsive.isDesktop(context)
                        ? MediaQuery.of(context).size.width / 3.5
                        : double.infinity,
                    child: Obx(() {
                      return Column(
                        children: [
                          ReviewWidget(
                            title: "Review project",
                            isClient: AppPref().userType == 2,
                            projectName:
                                "Project name",
                            projectBudget:
                                '\$ 2400',
                            firstMileStoneBudget:
                                '\$ 1000',
                            mileStoneName:
                                "Milestone name",
                            tentativeStartDate: "2024-05-09",
                            deliverablesList: const [
                              "qdqwdqw",
                              "fefefefwefew",
                              "dqwdqwdqwdqd"
                            ],
                            attachmentList: ((reviewProjectController
                                            .projectInfo
                                            .value
                                            ?.project
                                            ?.first
                                            .milestone
                                            ?.first
                                            .attachments ??
                                        "")
                                    .isEmpty)
                                ? []
                                : jsonDecode(reviewProjectController
                                        .projectInfo
                                        .value
                                        ?.project
                                        ?.first
                                        .milestone
                                        ?.first
                                        .attachments ??
                                    ''),
                            projectNotes: "this is notes",
                            clientVendorEmail: "demo@gmail.com",
                            clientVendorName: "demo",
                            mileStoneBudgetTitle: "FIRST MILESTONE BUDGET",
                            mileStoneDetailTitle: "FIRST MILESTONE",
                          ),
                          const Gap(32),
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
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              const Gap(16),
                              Expanded(
                                flex: 2,
                                child: CommonAppButton(
                                  onTap: () {
                                    // GoRouter.of(context).go('/project');

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Obx(
                                            () => AddNoteDialog(
                                              buttonType:
                                                  reviewProjectController
                                                          .isLoading.value
                                                      ? ButtonType.progress
                                                      : ButtonType.enable,
                                              onCancelTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              textEditingController:
                                                  TextEditingController(),
                                              onSendTap: (val) async {
                                                await reviewProjectController
                                                    .sendForReviewApi(
                                                  context: context,
                                                  projectId:
                                                      widget.projectId ?? "",
                                                );
                                              },
                                            ),
                                          );
                                        });
                                  },
                                  text: "Send for review",
                                  buttonType: ButtonType.enable,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          if (reviewProjectController.isGetProjectLoading.value)
            Center(child: showLoadingDialog()),
        ],
      );
    });
  }
}
