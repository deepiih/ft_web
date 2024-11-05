import 'dart:convert';

import 'package:sectar_web/components/Dialog/add_note_dialog.dart';
import 'package:sectar_web/components/Dialog/common_dialog.dart';
import 'package:sectar_web/components/review_widget.dart';
import 'package:sectar_web/modules/tab/project/client/client_project_review_controller.dart';
import 'package:sectar_web/package/config_packages.dart';

class ClientProjectReviewScreen extends StatefulWidget {
  const ClientProjectReviewScreen(
      {super.key, this.projectId, this.milestoneId});

  final String? projectId;
  final String? milestoneId;

  @override
  State<ClientProjectReviewScreen> createState() =>
      _ClientProjectReviewScreenState();
}

class _ClientProjectReviewScreenState extends State<ClientProjectReviewScreen> {
  final clientProjectReviewController =
      Get.put<ClientProjectReviewController>(ClientProjectReviewController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await clientProjectReviewController.getProjectInfo(context,
          projectId: widget.projectId ?? "");
      if ((widget.milestoneId ?? "").isNotEmpty) {
        await clientProjectReviewController.getMilestoneInfo(
            milestoneId: widget.milestoneId ?? "");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ClientProjectReviewController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10.0,
                          right: Responsive.isDesktop(context) ? 100 : 20,
                          top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "",
                            style: const TextStyle()
                                .normal16w400
                                .textColor(AppColor.textSecondaryColor),
                          ),
                          if (AppPref().token.isNotEmpty)
                            const CloseTextButton(),
                        ],
                      ),
                    ),
                    const Gap(28),
                    if (Responsive.isDesktop(context)) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: SizedBox()),
                          _reviewWidget(),
                          if (clientProjectReviewController.projectInfo.value
                                  ?.project?.first.projectStatus
                                  ?.toLowerCase() ==
                              underReview.toLowerCase()) ...[
                            (AppPref().token.isEmpty || AppPref().userType == 2)
                                ? _buildProjectActionWidget(context)
                                : Expanded(
                                    child: SizedBox(),
                                  ),
                          ] else if ((widget.milestoneId ?? "").isNotEmpty &&
                              clientProjectReviewController
                                      .milestoneInfo.value?.milestoneStatus
                                      ?.toLowerCase() ==
                                  underReview.toLowerCase()) ...[
                            (AppPref().token.isEmpty || AppPref().userType == 2)
                                ? _buildMilestoneActionWidget(context)
                                : Expanded(
                                    child: SizedBox(),
                                  )
                          ] else ...[
                            const Expanded(child: SizedBox()),
                          ]
                        ],
                      ),
                    ] else ...[
                      Column(
                        children: [
                          Row(
                            children: [
                              _reviewWidget(),
                            ],
                          ),
                          if (clientProjectReviewController.projectInfo.value
                                  ?.project?.first.projectStatus
                                  ?.toLowerCase() ==
                              underReview.toLowerCase()) ...[
                            Row(
                              children: [
                                _buildProjectActionWidget(context),
                              ],
                            ),
                          ] else if ((widget.milestoneId ?? "").isNotEmpty &&
                              clientProjectReviewController
                                      .milestoneInfo.value?.milestoneStatus
                                      ?.toLowerCase() ==
                                  underReview.toLowerCase()) ...[
                            Row(
                              children: [
                                _buildMilestoneActionWidget(context),
                              ],
                            )
                          ]
                        ],
                      ),
                    ],
                    const Gap(32),
                  ],
                ),
              ),
            ),
            if (clientProjectReviewController.isGetProjectLoading.value)
              Center(child: showLoadingDialog()),
          ],
        );
      }),
    );
  }

  Expanded _buildMilestoneActionWidget(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context) ? 0 : 60,
          vertical: Responsive.isMobile(context) ? 20 : 0,
        ),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColor.backgroundStokeColor,
            width: 0.9,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Hi ${AppPref().name}, please submit your response about the milestone.",
              style: const TextStyle()
                  .normal18w400
                  .textColor(AppColor.lightBlackColor),
            ),
            const Gap(24),
            CommonAppButton(
              onTap: () async {
                if (AppPref().token.isEmpty) {
                  d(context);
                } else {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return Obx(() {
                          return CommonDialog(
                            leftSideIcon: AppImage.right,
                            leftSideIconColor: AppColor.successStatusColor,
                            buttonColor: AppColor.successStatusColor,
                            title: "Approve & fund milestone?",
                            content1:
                                'You have to add funds for the \nmilestone to make the milestone live',
                            buttonText: "Approve & fund the milestone",
                            buttonFlex: 6,
                            buttonType:
                                clientProjectReviewController.isLoading.value
                                    ? ButtonType.progress
                                    : ButtonType.enable,
                            buttonTap: () async {
                              await clientProjectReviewController
                                  .approveMilestone(
                                context: context,
                                mileStoneId: clientProjectReviewController
                                        .milestoneInfo.value?.id
                                        .toString() ??
                                    "",
                              );
                            },
                          );
                        });
                      });
                }
              },
              text: 'Approve milestone',
              isAddButton: true,
              buttonColor: AppColor.successStatusColor,
              buttonType: ButtonType.enable,
            ),
            const Gap(16),
            Text(
              "Note : You will fund the milestone budget of \$ ${clientProjectReviewController.milestoneInfo.value?.milestoneBudget}",
              style: const TextStyle()
                  .normal16w400
                  .textColor(AppColor.textSecondaryColor),
            ),
            const Gap(24),
            CommonAppButton(
              onTap: () async {
                if (AppPref().token.isEmpty) {
                  d(context);
                } else {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return Obx(() {
                          return AddNoteDialog(
                            onCancelTap: () {
                              Navigator.of(context).pop();
                            },
                            buttonType:
                                clientProjectReviewController.isLoading.value
                                    ? ButtonType.progress
                                    : ButtonType.enable,
                            onSendTap: (val) async {
                              await clientProjectReviewController
                                  .requestChangesMilestone(
                                context: context,
                                milestoneId: clientProjectReviewController
                                        .milestoneInfo.value?.id
                                        .toString() ??
                                    "",
                                changes: val,
                              );
                            },
                            note: 'We will add this to the email',
                            title: 'Specify changes',
                            textEditingController: TextEditingController(),
                          );
                        });
                      });
                }
              },
              text: 'Request changes',
              isAddButton: true,
              buttonColor: AppColor.lightBlackColor,
              buttonType: ButtonType.enable,
            ),
            const Gap(24),
            TextButton(
              onPressed: () async {
                if (AppPref().token.isEmpty) {
                  d(context);
                } else {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return Obx(() {
                          return CommonDialog(
                            leftSideIcon: AppImage.danger,
                            leftSideIconColor: AppColor.errorStatusColor,
                            buttonColor: AppColor.errorStatusColor,
                            title: "Are you sure to reject the milestone?",
                            content1:
                                'Rejecting the milestone will disable further\nnegotiations. This can’t be undone.',
                            buttonText: "Reject milestone",
                            buttonFlex: 2,
                            buttonType:
                                clientProjectReviewController.isLoading.value
                                    ? ButtonType.progress
                                    : ButtonType.enable,
                            buttonTap: () async {
                              await clientProjectReviewController
                                  .rejectMileStone(
                                context: context,
                                mileStoneId: clientProjectReviewController
                                        .milestoneInfo.value?.id
                                        .toString() ??
                                    "",
                              );
                            },
                          );
                        });
                      });
                }
              },
              child: Text(
                "Reject milestone",
                style: const TextStyle()
                    .normal18w400
                    .textColor(AppColor.errorStatusColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildProjectActionWidget(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context) ? 0 : 60,
          vertical: Responsive.isMobile(context) ? 20 : 0,
        ),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColor.backgroundStokeColor,
            width: 0.9,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Hi ${AppPref().name}, please submit your response about the project.",
              style: const TextStyle()
                  .normal18w400
                  .textColor(AppColor.lightBlackColor),
            ),
            const Gap(24),
            CommonAppButton(
              onTap: () async {
                if (AppPref().token.isEmpty) {
                  d(context);
                } else {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return Obx(() {
                          return CommonDialog(
                            leftSideIcon: AppImage.right,
                            leftSideIconColor: AppColor.successStatusColor,
                            buttonColor: AppColor.successStatusColor,
                            title: "Approve & fund project?",
                            content1:
                                'You have to add funds for the first\nmilestone to make the project live',
                            buttonText: "Approve and fund the project",
                            buttonFlex: 6,
                            buttonType:
                                clientProjectReviewController.isLoading.value
                                    ? ButtonType.progress
                                    : ButtonType.enable,
                            buttonTap: () async {
                              await clientProjectReviewController
                                  .approveProjectApi(
                                      context: context,
                                      projectId: widget.projectId ?? "",
                                      autoPay: clientProjectReviewController
                                          .selectedAUTOPAY.value);
                            },
                          );
                        });
                      });
                }
              },
              text: 'Approve project',
              isAddButton: true,
              buttonColor: AppColor.successStatusColor,
              buttonType: ButtonType.enable,
            ),
            const Gap(16),
            Text(
              "Note : You will fund the first milestone budget of \$ ${clientProjectReviewController.projectInfo.value?.project?.first.milestone?.first.milestoneBudget ?? ""} to kickstart project",
              style: const TextStyle()
                  .normal16w400
                  .textColor(AppColor.textSecondaryColor),
            ),
            const Gap(24),
            CommonAppButton(
              onTap: () async {
                if (AppPref().token.isEmpty) {
                  d(context);
                } else {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return Obx(() {
                          return AddNoteDialog(
                            onCancelTap: () {
                              Navigator.of(context).pop();
                            },
                            buttonType:
                                clientProjectReviewController.isLoading.value
                                    ? ButtonType.progress
                                    : ButtonType.enable,
                            onSendTap: (val) async {
                              await clientProjectReviewController
                                  .requestChangesProjectApi(
                                context: context,
                                projectId: widget.projectId ?? "",
                                changes: val,
                              );
                            },
                            note: 'We will add this to the email',
                            title: 'Specify changes',
                            textEditingController: TextEditingController(),
                          );
                        });
                      });
                }
              },
              text: 'Request changes',
              isAddButton: true,
              buttonColor: AppColor.lightBlackColor,
              buttonType: ButtonType.enable,
            ),
            const Gap(24),
            TextButton(
              onPressed: () async {
                if (AppPref().token.isEmpty) {
                  d(context);
                } else {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return Obx(() {
                          return CommonDialog(
                            leftSideIcon: AppImage.danger,
                            leftSideIconColor: AppColor.errorStatusColor,
                            buttonColor: AppColor.errorStatusColor,
                            title: "Are you sure to reject the project?",
                            content1:
                                'Rejecting the project will disable further\nnegotiations. This can’t be undone.',
                            buttonText: "Reject project",
                            buttonFlex: 2,
                            buttonType:
                                clientProjectReviewController.isLoading.value
                                    ? ButtonType.progress
                                    : ButtonType.enable,
                            buttonTap: () async {
                              await clientProjectReviewController
                                  .rejectProjectApi(
                                      context: context,
                                      projectId: widget.projectId ?? "");
                            },
                          );
                        });
                      });
                }
              },
              child: Text(
                "Reject Project",
                style: const TextStyle()
                    .normal18w400
                    .textColor(AppColor.errorStatusColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _reviewWidget() {
    return Expanded(
      child: ReviewWidget(
        title: (widget.milestoneId ?? "").isNotEmpty
            ? "Milestone Approval Request"
            : "Project Approval Request",
        subtitle: Text.rich(
          textAlign: TextAlign.start,
          TextSpan(
            children: [
              TextSpan(
                text: 'Submitted by ',
                style: const TextStyle()
                    .normal18w400
                    .textColor(AppColor.textSecondaryColor),
              ),
              TextSpan(
                text:
                    clientProjectReviewController.projectInfo.value?.userName ??
                        "",
                style: const TextStyle()
                    .normal18w400
                    .textColor(AppColor.lightBlackColor),
              ),
              TextSpan(
                text: ' with email ',
                style: const TextStyle()
                    .normal18w400
                    .textColor(AppColor.textSecondaryColor),
              ),
              TextSpan(
                text: clientProjectReviewController
                        .projectInfo.value?.userEmail ??
                    "",
                style: const TextStyle()
                    .normal18w400
                    .textColor(AppColor.lightBlackColor),
              ),
              TextSpan(
                text: ' on ',
                style: const TextStyle()
                    .normal18w400
                    .textColor(AppColor.textSecondaryColor),
              ),
              TextSpan(
                text: ((widget.milestoneId ?? "").isNotEmpty)
                    ? ((clientProjectReviewController.milestoneInfo.value?.createdAt ?? "")
                            .isEmpty)
                        ? ""
                        : DateFormat(CommonDateFormat.E_d_MMMM_y).format(DateTime.parse(
                            clientProjectReviewController.milestoneInfo.value?.createdAt ??
                                ""))
                    : ((clientProjectReviewController.projectInfo.value?.project
                                    ?.first.milestone?.first.createdAt ??
                                "")
                            .isEmpty)
                        ? ""
                        : DateFormat(CommonDateFormat.E_d_MMMM_y).format(
                            DateTime.parse(clientProjectReviewController
                                    .projectInfo
                                    .value
                                    ?.project
                                    ?.first
                                    .milestone
                                    ?.first
                                    .createdAt ??
                                "")),
                style: const TextStyle()
                    .normal18w400
                    .textColor(AppColor.lightBlackColor),
              ),
            ],
          ),
        ),
        isShowAutoPayWidget: (widget.milestoneId ?? "").isEmpty,
        autoPayChildWidget: Obx(() {
          return IgnorePointer(
            ignoring: (clientProjectReviewController
                    .projectInfo.value?.project?.first.projectStatus
                    ?.toLowerCase() !=
                underReview.toLowerCase()),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Obx(() {
                      return Radio(
                        activeColor: AppColor.primaryColor,
                        groupValue:
                            clientProjectReviewController.selectedAUTOPAY.value,
                        value: clientProjectReviewController
                            .autoPayList[index].title,
                        onChanged: (val) {
                          clientProjectReviewController.selectedAUTOPAY.value =
                              clientProjectReviewController
                                      .autoPayList[index].title ??
                                  "";
                        },
                      );
                    }),
                    const Gap(10),
                    Text(
                      clientProjectReviewController.autoPayList[index].title ??
                          "",
                      style: const TextStyle()
                          .normal16w400
                          .textColor(AppColor.lightBlackColor),
                    ),
                    const Spacer(),
                    Text(
                      index == 0 ? "Recommended" : "",
                      style: const TextStyle()
                          .normal16w400
                          .textColor(AppColor.textSecondaryColor),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    height: 1,
                    color: AppColor.backgroundStokeColor,
                  ),
                );
              },
              itemCount: clientProjectReviewController.autoPayList.length,
            ),
          );
        }),
        mileStoneStartDate: ((widget.milestoneId ?? "").isNotEmpty)
            ? ((clientProjectReviewController.milestoneInfo.value?.startDate ??
                        "")
                    .isEmpty)
                ? ""
                : DateFormat(CommonDateFormat.E_d_MMMM_y).format(DateTime.parse(
                    clientProjectReviewController
                            .milestoneInfo.value?.startDate ??
                        ""))
            : "",
        mileStoneEndDate: ((widget.milestoneId ?? "").isNotEmpty)
            ? ((clientProjectReviewController.milestoneInfo.value?.endDate ??
                        "")
                    .isEmpty)
                ? ""
                : DateFormat(CommonDateFormat.E_d_MMMM_y).format(DateTime.parse(
                    clientProjectReviewController
                            .milestoneInfo.value?.endDate ??
                        ""))
            : "",
        mileStoneBudgetTitle: ((widget.milestoneId ?? "").isNotEmpty)
            ? "MILESTONE BUDGET"
            : "FIRST MILESTONE BUDGET",
        mileStoneDetailTitle: ((widget.milestoneId ?? "").isNotEmpty)
            ? "MILESTONE DETAIL"
            : "FIRST MILESTONE DETAIL",
        isClient: AppPref().userType == 2,
        projectName: clientProjectReviewController
                .projectInfo.value?.project?.first.projectName ??
            "",
        projectBudget:
            '\$ ${clientProjectReviewController.projectInfo.value?.project?.first.estimatedBudget ?? ""}',
        firstMileStoneBudget: ((widget.milestoneId ?? "").isNotEmpty)
            ? '\$ ${clientProjectReviewController.milestoneInfo.value?.milestoneBudget ?? ""}'
            : '\$ ${clientProjectReviewController.projectInfo.value?.project?.first.milestone?.first.milestoneBudget ?? ""}',
        mileStoneName: ((widget.milestoneId ?? "").isNotEmpty)
            ? clientProjectReviewController.milestoneInfo.value?.milestoneName
            : clientProjectReviewController.projectInfo.value?.project?.first
                    .milestone?.first.milestoneName ??
                "",
        tentativeStartDate: ((clientProjectReviewController.projectInfo.value
                        ?.project?.first.milestone?.first.startDate ??
                    "")
                .isEmpty)
            ? ""
            : DateFormat(CommonDateFormat.E_d_MMMM_y).format(DateTime.parse(
                clientProjectReviewController.projectInfo.value?.project?.first
                        .milestone?.first.startDate ??
                    "")),
        deliverablesList: ((widget.milestoneId ?? "").isNotEmpty)
            ? ((clientProjectReviewController
                            .milestoneInfo.value?.deliverables ??
                        "")
                    .isEmpty)
                ? []
                : jsonDecode(clientProjectReviewController
                        .milestoneInfo.value?.deliverables ??
                    '')
            : ((clientProjectReviewController.projectInfo.value?.project?.first
                            .milestone?.first.deliverables ??
                        "")
                    .isEmpty)
                ? []
                : jsonDecode(clientProjectReviewController.projectInfo.value
                        ?.project?.first.milestone?.first.deliverables ??
                    ''),
        projectNotes: clientProjectReviewController
                .projectInfo.value?.project?.first.projectNotes ??
            "",
        clientVendorEmail:
            clientProjectReviewController.projectInfo.value?.userEmail ?? "",
        clientVendorName:
            clientProjectReviewController.projectInfo.value?.userName ?? "",
        attachmentList: ((widget.milestoneId ?? "").isNotEmpty)
            ? ((clientProjectReviewController
                            .milestoneInfo.value?.attachments ??
                        "")
                    .isEmpty)
                ? []
                : jsonDecode(clientProjectReviewController
                        .milestoneInfo.value?.attachments ??
                    '')
            : ((clientProjectReviewController.projectInfo.value?.project?.first
                            .milestone?.first.attachments ??
                        "")
                    .isEmpty)
                ? []
                : jsonDecode(clientProjectReviewController.projectInfo.value
                        ?.project?.first.milestone?.first.attachments ??
                    ''),
      ),
    );
  }

  void d(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CommonDialog(
            leftSideIcon: AppImage.view,
            leftSideIconColor: AppColor.primaryColor,
            buttonColor: AppColor.primaryColor,
            title: "Please Login",
            content1: 'Please Login/Register\nto complete this action',
            buttonText: "Login",
            buttonFlex: 6,
            buttonType: ButtonType.enable,
            buttonTap: () async {
              Navigator.pop(context);
              AppPref().clear();
              context.pushReplacementNamed(GoRouterNamed.login);
            },
          );
        });
  }
}
