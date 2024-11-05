import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

import '../../../../components/Dialog/project_close_dialog.dart';
import '../../../../data/model/milestone_model.dart';
import '../task/task_controller.dart';

class ProjectDashScreen extends StatefulWidget {
  const ProjectDashScreen({super.key, required this.projectId});

  final String projectId;

  @override
  State<ProjectDashScreen> createState() => _ProjectDashScreenState();
}

class _ProjectDashScreenState extends State<ProjectDashScreen> {
  final projectDashController = Get.put<ProjectDashController>(ProjectDashController());
  final taskController = Get.put<TaskController>(TaskController());

  @override
  void initState() {
    if ((widget.projectId).isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        projectDashController.getProjectInfo(projectId: widget.projectId);
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ProjectDashController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleSubTitleWidget(
                            text1: CommonString.projectDashboard,
                            text2:
                                "${CommonString.project} :  ${projectDashController.projectInfo.value?.project?.first.projectName ?? ""} • ${CommonString.clientText} : ${projectDashController.projectInfo.value?.project?.first.clientName ?? ""}",
                          ),
                          Row(
                            children: [
                              // const SaveDraftButton(
                              //   isHasBorder: true,
                              //   textColor: AppColor.black,
                              //   icon: AppImage.leftArrow,
                              //   text: CommonString.goBack,
                              //   iconColor: AppColor.textSecondaryColor,
                              // ),
                              // const Gap(10),
                              if (AppPref().userType == 1) _projectAction(context),
                              // SquareButton(),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(32),
                          Text(
                            CommonString.overview.toUpperCase(),
                            style: const TextStyle().normal18w400.textColor(AppColor.black),
                          ),
                          const Gap(23),
                          OverViewWidget(
                            overViewList: projectDashController.overView,
                          ),
                          const Gap(40),
                          Visibility(
                            visible: (projectDashController.projectInfo.value?.project?.first.milestone ?? []).isNotEmpty,
                            child: Column(
                              children: [
                                Text(
                                  CommonString.mileStones.toUpperCase(),
                                  style: const TextStyle().normal18w400.textColor(AppColor.black),
                                ),
                                const Gap(16),
                              ],
                            ),
                          ),
                          Wrap(
                            spacing: 24,
                            runSpacing: 24,
                            children: List.generate(projectDashController.projectInfo.value?.project?.first.milestone?.length ?? 0, (index) {
                              Milestone? milestone = projectDashController.projectInfo.value?.project?.first.milestone?[index];
                              return GestureDetector(
                                onTap: () {
                                  //////for freelancer /////////
                                  if (AppPref().userType == 1) {
                                    if (milestone?.milestoneStatus?.toLowerCase() == live.toLowerCase()) {
                                      goToTaskDashboard(milestone);
                                    } else {
                                      goToDefaultView(milestone);
                                    }
                                  }
                                  ///////////for client//////////////
                                  else {
                                    if (milestone?.milestoneStatus?.toLowerCase() == live.toLowerCase()) {
                                      goToTaskDashboard(milestone);
                                    } else if (milestone?.milestoneStatus?.toLowerCase() == underReview.toLowerCase() || milestone?.milestoneStatus?.toLowerCase() == changesNeeded.toLowerCase()) {
                                      goToClientReviewProject(milestone);
                                    } else {
                                      goToDefaultView(milestone);
                                    }
                                  }
                                },
                                child: _buildMileStone(milestone),
                              );
                            }).toList(),
                          ),
                          const Gap(48),
                          if (AppPref().userType == 1) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  CommonString.transactions.toUpperCase(),
                                  style: const TextStyle().normal18w400.textColor(AppColor.black),
                                ),
                                const Gap(23),
                                _transactionWidget(),
                                const Gap(48),
                              ],
                            ),
                          ]
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (projectDashController.isGetProjectLoading.value) ...[
            Center(child: showLoadingDialog()),
          ]
        ],
      );
    });
  }

  void goToTaskDashboard(Milestone? milestone) {
    GoRouter.of(context).pushNamed(
      GoRouterNamed.task,
      queryParameters: {
        Param.milestoneId: milestone?.id.toString(),
      },
    );
  }

  void goToDefaultView(Milestone? milestone) {
    GoRouter.of(context).pushNamed(
      GoRouterNamed.view,
      queryParameters: {
        'projectId': projectDashController.projectInfo.value?.project?.first.id.toString(),
        'milestoneId': milestone?.id.toString(),
      },
    );
  }

  void goToClientReviewProject(Milestone? milestone) {
    GoRouter.of(context).pushNamed(
      GoRouterNamed.clientReviewProject,
      queryParameters: {
        'projectId': projectDashController.projectInfo.value?.project?.first.id.toString(),
        'milestoneId': milestone?.id.toString(),
      },
    );
  }

  Theme _projectAction(context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: PopupMenuButton<String>(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: AppColor.white,
        onSelected: (String choice) async {
          if (choice == 'new_milestone') {
            GoRouter.of(context).pushNamed(
              GoRouterNamed.step2,
              queryParameters: {
                'projectId': projectDashController.projectInfo.value?.project?.first.id.toString(),
              },
              pathParameters: <String, String>{'isFromAddMileStone': '0'},
            );
          } else if (choice == "close_project") {
            // await showDialog(
            //     context: context,
            //     builder: (context) {
            //       return Obx(() {
            //         return AddNoteDialog(
            //           buttonText: "Close milestone",
            //           iconColor: AppColor.errorStatusColor,
            //           icon: AppImage.danger,
            //           onCancelTap: () {
            //             Navigator.of(context).pop();
            //           },
            //           buttonType: projectDashController.isLoading.value ? ButtonType.progress : ButtonType.enable,
            //           onSendTap: (val) async {
            //             await projectDashController.closeMilestone(
            //               context: context,
            //               mileStoneId: widget.milestoneId ?? "",
            //             );
            //           },
            //           content:
            //               "If you managed to successfully finish\nand get paid for all the work in the milestone. If\nyou don’t plan to use the milestone any more,\nplease close it.\nNote that, once the milestone is closed, you\ncan’t re-open it. We will also send an email to\nthe client about the say.",
            //           title: 'All work done?',
            //           textEditingController: TextEditingController(),
            //         );
            //       });
            //     });

            showDialog(
                context: context,
                builder: (context) {
                  return Obx(() {
                    return ProjectCloseDialog(
                      titleText: "Hey are you sure to close this\nproject?",
                      displayText: "You can’t create any more milestones or\ntasks under this project once closed.",
                      negativeButtonText: "Close project",
                      positiveButtonText: "Keep project",
                      isSuccess: false,
                      buttonType: taskController.isLoading.value ? ButtonType.progress : ButtonType.enable,
                      onTap: () async {
                        await taskController.closeProject(
                          context: context,
                          projectId: widget.projectId ?? "",
                        );
                      },
                    );
                  });
                });
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          if (AppPref().userType == 1) ...[
            PopupMenuItem<String>(
              value: 'new_milestone',
              child: ListTile(
                leading: Image.asset(
                  AppImage.createProject,
                  height: 20,
                  color: AppColor.textSecondaryColor,
                ),
                title: Text(
                  'Add new milestone',
                  style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: 'close_project',
              child: ListTile(
                leading: Image.asset(
                  AppImage.right,
                  height: 20,
                  color: AppColor.successStatusColor,
                ),
                title: Text(
                  'Close project',
                  style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                ),
              ),
            ),
          ]
        ],
        child: Container(
          height: 43,
          width: 43,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.white, border: Border.all(color: AppColor.backgroundStokeColor)),
          child: const Icon(Icons.more_horiz),
        ),
      ),
    );
  }

  Container _transactionWidget() {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 5,
            color: AppColor.black.withOpacity(0.11),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                AppImage.stripe,
                height: 48,
                width: 48,
              ),
            ],
          ),
          const Gap(32),
          Text(
            CommonString.viewTransactioninStripe,
            style: const TextStyle().normal20w700.textColor(AppColor.black),
          ),
          const Gap(8),
          Text(
            CommonString.itsNotIDel,
            style: const TextStyle().normal18w400.textColor(AppColor.black),
          ),
          const Gap(24),
          const CommonAppButton(
            text: CommonString.openStripeDashboard,
            buttonType: ButtonType.enable,
            width: 213,
          )
        ],
      ),
    );
  }

  Container _buildMileStone(Milestone? milestone) {
    return Container(
      width: 286,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 5,
            color: AppColor.black.withOpacity(0.11),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(86),
              color: HexColor.fromHex(milestone?.milestoneColor ?? ""),
            ),
            child: Text(
              milestone?.milestoneStatus ?? "",
              style: const TextStyle().normal16w400.textColor(AppColor.white),
            ),
          ),
          const Gap(17),
          Text(
            CommonString.mileStone,
            style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
          ),
          const Gap(8),
          Text(
            milestone?.milestoneName ?? "",
            style: const TextStyle().normal18w400.textColor(AppColor.black),
          ),
          const Gap(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(86), color: AppColor.black),
                child: Text(
                  '\$ ${milestone?.milestoneBudget ?? ""}',
                  style: const TextStyle().normal16w400.textColor(AppColor.white),
                ),
              ),
              Text(
                ((milestone?.startDate ?? "").isEmpty) ? "" : DateFormat(CommonDateFormat.E_d_MMMM_y).format(DateTime.parse(milestone?.startDate ?? "")),
                style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
