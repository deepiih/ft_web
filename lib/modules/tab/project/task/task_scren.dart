import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:sectar_web/components/Dialog/add_task_dialog.dart';
import 'package:sectar_web/components/Dialog/common_dialog.dart';
import 'package:sectar_web/components/Dialog/project_close_dialog.dart';
import 'package:sectar_web/components/Dialog/task_under_review_dialog.dart';
import 'package:sectar_web/data/model/all_task.dart';
import 'package:sectar_web/modules/tab/project/task/task_controller.dart';
import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

import '../../../../components/Dialog/project_success_dialog.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, this.milestoneId});

  final String? milestoneId;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final taskController = Get.put<TaskController>(TaskController());

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     await taskController.getAllTaskApi(mid: widget.milestoneId ?? "");
  //   });
  // }

  @override
  void dispose() {
    Get.delete<TaskController>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleSubTitleWidget(
                    text1: "Authentication Module",
                    text2: "Project : Login Module • Client : Roy Jack",
                    titleChildWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Gap(8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(86),
                            color: const Color(0xFF34A853),
                          ),
                          child: Text(
                            "Live",
                            style: const TextStyle().normal14w400.textColor(AppColor.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: Responsive.isDesktop(context),
                    child: _buildRow(context),
                  )
                ],
              ),
              Visibility(
                visible: Responsive.isMobile(context),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: _buildRow(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: _buildAddTakAndProjectAction(context),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider(
          color: AppColor.backgroundStokeColor,
        ),
        // Expanded(
        //   child: SingleChildScrollView(
        //     padding: const EdgeInsets.all(20),
        //     child: NoProjectOrFreelancerWidget(
        //       title: CommonString.noTaskYet,
        //       subTitle: AppPref().userType == 1 ? CommonString.startCreatingTask : CommonString.noTaskClient,
        //       buttonText: CommonString.createTask,
        //       title1: CommonString.watchVideo,
        //       subTitle1: CommonString.learnTaskManage,
        //       onTap: () {
        //         showDialog(
        //             context: context,
        //             builder: (context) {
        //               return Obx(() {
        //                 return AddTaskDialog(
        //                   availableBudget: taskController.availableBudget.toString(),
        //                   buttonType: taskController.isLoading.value ? ButtonType.progress : ButtonType.enable,
        //                   onTap: (Task data) async {
        //                     await taskController.createTaskApi(
        //                       mileStoneId: widget.milestoneId ?? "",
        //                       context: context,
        //                       taskStatus: data.taskStatus ?? "",
        //                       taskName: data.taskName ?? "",
        //                       description: data.description ?? "",
        //                       dueDate: data.dueDate,
        //                       taskBudget: data.taskBudget,
        //                     );
        //                   },
        //                 );
        //               });
        //             });
        //       },
        //     ),
        //   ),
        // ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 30, right: 30),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ["Planned", "To Do", "In Progress", "Under Review", "Changes Requested", "Approved"].map((e) {
                return Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _taskPlanWidget(
                          taskCategory: "In Progress",
                          price: '299',
                          tasks: "19",
                          color: "#34A853",
                        ),
                        const Gap(20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                3,
                                (index) {
                                  return _taskWidget(
                                    context: context,
                                    category: "UI design",
                                    data: Task(
                                      taskStatus: "In Progress",
                                      taskPaymentStatus: "wefde",
                                      taskName: "Task Name",
                                      id: 3,
                                      createdAt: '2023-04-08',
                                      autoPayDate: '2023-04-08',
                                      deletedAt: '2023-04-08',
                                      dueDate: '2023-04-08',
                                      taskColor: "#34A853",
                                      taskBudget: 500
                                    ),
                                    color: "#34A853",
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Row _taskPlanWidget({
    required String taskCategory,
    required String price,
    required String tasks,
    required String color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipOval(
              child: Container(
                height: 12,
                width: 12,
                color: HexColor.fromHex(color),
              ),
            ),
            const Gap(8),
            Text(
              taskCategory.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
            ),
          ],
        ),
        const Gap(20),
        Text(
          "\$$price • $tasks Tasks",
          textAlign: TextAlign.center,
          style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
        ),
      ],
    );
  }

  GestureDetector _taskWidget({
    required BuildContext context,
    required String category,
    required String color,
    required Task? data,
  }) {
    return GestureDetector(
      onTap: () {
        if (!(data?.taskStatus?.toLowerCase() == approvedTask.toLowerCase() || data?.taskStatus?.toLowerCase() == paidOutTask.toLowerCase())) {
          showDialog(
              context: context,
              builder: (context) {
                return Obx(() {
                  return TaskUnderReviewDialog(
                    onApproveTask: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return Obx(() {
                              return CommonDialog(
                                leftSideIcon: AppImage.right,
                                leftSideIconColor: AppColor.successStatusColor,
                                buttonColor: AppColor.successStatusColor,
                                title: "Are you sure to approve the task?",
                                content1: 'we will release the funds\nfor this task',
                                buttonText: "Approve Task",
                                buttonFlex: 6,
                                buttonType: taskController.isApproveTaskLoading.value ? ButtonType.progress : ButtonType.enable,
                                buttonTap: () async {
                                  await taskController.approveTaskApi(
                                    mileStoneId: widget.milestoneId ?? "",
                                    context: context,
                                    taskId: data?.id.toString() ?? "",
                                  );
                                },
                              );
                            });
                          });
                    },
                    onReqChange: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return Obx(() {
                              return AddNoteDialog(
                                onCancelTap: () {
                                  Navigator.of(context).pop();
                                },
                                buttonType: taskController.isTaskChangesLoading.value ? ButtonType.progress : ButtonType.enable,
                                onSendTap: (val) async {
                                  await taskController.taskChangeRequest(
                                    context: context,
                                    mileStoneId: widget.milestoneId ?? "",
                                    taskId: data?.id.toString() ?? "",
                                    taskChangesNote: val,
                                  );
                                },
                                note: 'We will add this to the email',
                                title: 'Specify changes',
                                textEditingController: TextEditingController(),
                              );
                            });
                          });
                    },
                    onDeleteTap: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return Obx(() {
                              return DeleteProjectDialog(
                                title: "Delete task?",
                                buttonText: 'Delete Task',
                                subTitle: "Are you sure you want to delete this task?",
                                onTap: () async {
                                  await taskController.deleteTaskApi(
                                    context: context,
                                    id: data?.id.toString() ?? "",
                                    mileStoneId: widget.milestoneId.toString(),
                                  );
                                },
                                buttonType: taskController.isDeleteTaskLoading.value ? ButtonType.progress : ButtonType.enable,
                              );
                            });
                          });
                    },
                    onDoneTap: (Task taskStatusModel) async {
                      await taskController.createTaskApi(
                          taskId: data?.id.toString(),
                          mileStoneId: widget.milestoneId ?? "",
                          context: context,
                          taskStatus: taskStatusModel.taskStatus ?? "",
                          dueDate: taskStatusModel.dueDate,
                          taskBudget: taskStatusModel.taskBudget,
                          taskName: taskStatusModel.taskName,
                          description: taskStatusModel.description);
                    },
                    isClient: AppPref().userType == 2,
                    buttonType: taskController.isLoading.value ? ButtonType.progress : ButtonType.enable,
                    task: data,
                    availableBudget: taskController.availableBudget.toString(),
                  );
                });
              });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        width: Responsive.isMobile(context) ? 287 : 287,
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border(
            bottom: BorderSide(
              color: HexColor.fromHex(color),
              width: 3.0,
            ),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 5,
              color: AppColor.black.withOpacity(0.11),
            )
          ],
          borderRadius: BorderRadius.circular(2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    data?.taskName ?? "",
                    style: const TextStyle().normal16w400.textColor(
                          AppColor.lightBlackColor,
                        ),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Row(
              children: [
                DottedBorder(
                  color: AppColor.backgroundStokeColor,
                  dashPattern: const [3, 3, 3, 3],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(48),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImage.calendar,
                          color: AppColor.textSecondaryColor,
                          height: 20,
                        ),
                        const Gap(8),
                        Text(
                          DateFormat('E, d MMM').format(DateTime.parse(data?.dueDate ?? "")),
                          textAlign: TextAlign.center,
                          style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                DottedBorder(
                  color: AppColor.backgroundStokeColor,
                  dashPattern: const [3, 3, 3, 3],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(48),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImage.dollar,
                          color: AppColor.textSecondaryColor,
                          height: 20,
                        ),
                        const Gap(4),
                        Text(
                          "\$${data?.taskBudget.toString() ?? ""}",
                          textAlign: TextAlign.center,
                          style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildRow(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppImage.payment,
                  height: 25,
                ),
                const Gap(8),
                Obx(() {
                  return Text(
                    "\$${taskController.availableBudget.value}",
                    style: const TextStyle().normal20w400.textColor(AppColor.lightBlackColor),
                  );
                }),
                const Gap(15),
                _availableMileStone(),
              ],
            ),
            const Gap(12),
            SizedBox(
              height: 5,
              width: 240,
              child: FAProgressBar(
                backgroundColor: AppColor.backgroundStokeColor,
                progressColor: AppColor.successStatusColor,
                currentValue: (double.parse(taskController.getAllTaskModel.value?.milestone?.milestoneBudget.toString() ?? "0.0") -
                    double.parse(taskController.getAllTaskModel.value?.allTaskBudget.toString() ?? "0.0")),
                maxValue: double.parse(taskController.getAllTaskModel.value?.milestone?.milestoneBudget.toString() ?? "0.0"),
              ),
            ),
          ],
        ),
        const Gap(20),
        // if (taskController.getAllTaskModel.value?.milestone?.milestoneStatus?.toLowerCase() == live.toLowerCase())
          Visibility(
            visible: Responsive.isDesktop(context),
            child: _buildAddTakAndProjectAction(context),
          ),
      ],
    );
  }

  Row _buildAddTakAndProjectAction(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: AppPref().userType == 1,
          child: CommonAppButton(
            text: 'Add Task',
            width: 90,
            buttonType: ButtonType.enable,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Obx(() {
                      return AddTaskDialog(
                        availableBudget: taskController.availableBudget.toString(),
                        buttonType: taskController.isLoading.value ? ButtonType.progress : ButtonType.enable,
                        onTap: (Task data) async {
                          await taskController.createTaskApi(
                            mileStoneId: taskController.getAllTaskModel.value?.milestone?.id ?? "",
                            context: context,
                            taskStatus: data.taskStatus ?? "",
                            taskName: data.taskName ?? "",
                            description: data.description ?? "",
                            dueDate: data.dueDate,
                            taskBudget: data.taskBudget,
                          );
                        },
                      );
                    });
                  });
            },
          ),
        ),
        const Gap(16),
        _projectAction(context),
      ],
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
            if (taskController.getAllTaskModel.value?.milestone?.milestoneStatus?.toLowerCase() == live.toLowerCase()) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ProjectSuccessDialog(
                      titleText: "There is one milestone currently\nlive. Please mark it as complete \nbefore you create a new milestone.",
                      displayText: "We know this is not ideal.",
                      buttonText: "Okay",
                      isSuccess: false,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    );
                  });
            } else {
              GoRouter.of(context).pushNamed(
                GoRouterNamed.step2,
                queryParameters: {'projectId': (taskController.getAllTaskModel.value?.project?.id.toString() ?? "")},
                pathParameters: <String, String>{'isFromAddMileStone': '0'},
              );
            }
          } else if (choice == 'dashboard') {
            GoRouter.of(context).pushNamed(
              GoRouterNamed.projectDashboard,
              queryParameters: {'projectId': (taskController.getAllTaskModel.value?.project?.id.toString() ?? "")},
            );
          } else if (choice == "close_project") {
            if (taskController.getAllTaskModel.value?.milestone?.milestoneStatus?.toLowerCase() == live.toLowerCase()) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ProjectSuccessDialog(
                      titleText: "Hey, to close the project, please \nmark all milestones as complete.",
                      displayText: "This is to ensure safety and avoid fraud.\nWe hope you understand. ",
                      buttonText: "Okay",
                      isSuccess: false,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    );
                  });
            } else {
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
                          await taskController.closeProject(context: context, projectId: (taskController.getAllTaskModel.value?.project?.id.toString() ?? ""));
                        },
                      );
                    });
                  });
            }
          } else if (choice == "current_milestone") {
            //here I have to make entire list clickable
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'dashboard',
            child: ListTile(
              leading: Image.asset(
                AppImage.createProject,
                height: 20,
                color: AppColor.textSecondaryColor,
              ),
              title: Text(
                'Project Dashboard',
                style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
              ),
            ),
          ),
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
          ],
          PopupMenuItem<String>(
            value: 'current_milestone',
            child: _currentMilestoneAction(context),
          ),
          if (AppPref().userType == 1) ...[
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
          ],
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

  Theme _currentMilestoneAction(context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: PopupMenuButton<String>(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: AppColor.white,
        onSelected: (String choice) async {
          if (choice == 'refund_money') {
            await showDialog(
                context: context,
                builder: (context) {
                  return Obx(() {
                    return AddNoteDialog(
                      buttonText: "Process refund",
                      iconColor: AppColor.black,
                      maxLine: 1,
                      hintText: "Input",
                      errorText: "Please Enter refund amount",
                      textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                      icon: AppImage.dispute,
                      onCancelTap: () {
                        Navigator.of(context).pop();
                      },
                      buttonType: taskController.isLoading.value ? ButtonType.progress : ButtonType.enable,
                      onSendTap: (val) async {
                        await taskController.refundMilestone(
                          context: context,
                          reason: val,
                          mileStoneId: widget.milestoneId ?? "",
                        );
                      },
                      note:
                          '\nAvailable unallocated funds : \$${double.parse(taskController.getAllTaskModel.value?.milestone?.milestoneBudget.toString() ?? "0") - double.parse(taskController.getAllTaskModel.value?.allTaskBudget.toString() ?? "0")}\n\nPlease note, you can only refund funds that are not allocated to a task. If you want to refund allocated task funds too, please delete or remove the allocated funds to the tasks you want. ',
                      title: 'Enter amount to refund',
                      textEditingController: TextEditingController(),
                    );
                  });
                });
          } else if (choice == 'raise_dispute') {
            await showDialog(
                context: context,
                builder: (context) {
                  return Obx(() {
                    return AddNoteDialog(
                      buttonText: "Raise dispute",
                      iconColor: AppColor.orangeColor,
                      maxLine: 1,
                      hintText: "Enter reason",
                      errorText: "Please Enter reason",
                      icon: AppImage.dispute,
                      onCancelTap: () {
                        Navigator.of(context).pop();
                      },
                      buttonType: taskController.isLoading.value ? ButtonType.progress : ButtonType.enable,
                      onSendTap: (val) async {
                        await taskController.disputeMilestone(
                          context: context,
                          reason: val,
                          mileStoneId: widget.milestoneId ?? "",
                        );
                      },
                      note:
                          'Please note, raising will also close the\nmilestone automatically. We know this is not\nideal.\n\nAs a way to maintain transparency, we will also\nemail the service provider about the same. ',
                      title: 'Raise a dispute',
                      textEditingController: TextEditingController(),
                    );
                  });
                });
          } else if (choice == 'complete_milestone') {
            if ((double.parse(taskController.getAllTaskModel.value?.milestone?.milestoneBudget.toString() ?? "0.0") -
                    (double.parse(taskController.getAllTaskModel.value?.paidOutFunds.toString() ?? "0.0"))) >
                0) {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return Obx(() {
                      return AddNoteDialog(
                        title: 'Complete Milestone?',
                        iconColor: AppColor.errorStatusColor,
                        icon: AppImage.danger,
                        onCancelTap: () {
                          Navigator.of(context).pop();
                        },
                        buttonType: taskController.isLoading.value ? ButtonType.progress : ButtonType.enable,
                        onSendTap: (val) async {
                          await taskController.closeMilestone(
                            context: context,
                            mileStoneId: widget.milestoneId ?? "",
                          );
                        },
                        content:
                            "There are milestone funds that are un-paid, including the ones in review, allocated and unallocated amounting to :\n\$${(double.parse(taskController.getAllTaskModel.value?.milestone?.milestoneBudget.toString() ?? "0.0") - (double.parse(taskController.getAllTaskModel.value?.paidOutFunds.toString() ?? "0.0")))}\n\nPlease refund the funds to continue to the client to continue. You can read about our refund policy to continue.Please note, for security purpose, the project will be paused and no activity can take place during this process.",
                        buttonText: "Initiate refund",
                        textEditingController: TextEditingController(),
                      );
                    });
                  });
            } else {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return Obx(() {
                      return AddNoteDialog(
                        title: 'All work done?',
                        content:
                            "Kudos, if you managed to successfully finish\nand get paid for all the work in the milestone. If\nyou don’t plan to use the milestone any more,\nplease close it.\nNote that, once the milestone is closed, you\ncan’t re-open it. We will also send an email to\nthe client about the say.",
                        iconColor: AppColor.errorStatusColor,
                        icon: AppImage.danger,
                        onCancelTap: () {
                          Navigator.of(context).pop();
                        },
                        buttonType: taskController.isLoading.value ? ButtonType.progress : ButtonType.enable,
                        onSendTap: (val) async {
                          await taskController.closeMilestone(
                            context: context,
                            mileStoneId: widget.milestoneId ?? "",
                          );
                        },
                        buttonText: "Close milestone",
                        textEditingController: TextEditingController(),
                      );
                    });
                  });
            }
            ;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          if (AppPref().userType == 1) ...[
            PopupMenuItem<String>(
              value: 'complete_milestone',
              child: ListTile(
                leading: Image.asset(
                  AppImage.right,
                  height: 20,
                  color: AppColor.textSecondaryColor,
                ),
                title: Text(
                  'Complete milestone',
                  style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: 'refund_money',
              child: ListTile(
                leading: Image.asset(
                  AppImage.dollar,
                  height: 20,
                  color: AppColor.textSecondaryColor,
                ),
                title: Text(
                  'Refund money to client',
                  style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                ),
              ),
            ),
          ],
          PopupMenuItem<String>(
            value: 'raise_dispute',
            child: ListTile(
              leading: Image.asset(
                AppImage.danger,
                height: 20,
                color: AppColor.errorStatusColor,
              ),
              title: Text(
                'Raise a dispute',
                style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
              ),
            ),
          ),
        ],
        child: ListTile(
          leading: Image.asset(
            AppImage.flag,
            height: 20,
            color: AppColor.primaryColor,
          ),
          // trailing: GestureDetector(
          //   onTap: () {},
          //   child: ,
          // ),
          trailing: const Icon(Icons.navigate_next),
          title: Text(
            'Current Milestone',
            style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
          ),
        ),
      ),
    );
  }

  Theme _availableMileStone() {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: PopupMenuButton<String>(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: AppColor.white,
        onSelected: (String choice) {},
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            enabled: false,
            value: 'milestone_funds',
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MILESTONE FUNDS',
                    style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                  ),
                  const Gap(18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${taskController.getAllTaskModel.value?.paidOutFunds.toString() ?? "0"}',
                        style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                      ),
                      Text(
                        '\$${taskController.getAllTaskModel.value?.milestone?.milestoneBudget ?? "0"}',
                        style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                      ),
                    ],
                  ),
                  const Gap(10),
                  SizedBox(
                    height: 5,
                    width: 215,
                    child: FAProgressBar(
                      backgroundColor: AppColor.backgroundStokeColor,
                      progressColor: AppColor.successStatusColor,
                      currentValue: ((double.parse(taskController.getAllTaskModel.value?.paidOutFunds.toString() ?? "0.0"))),
                      maxValue: double.parse(taskController.getAllTaskModel.value?.milestone?.milestoneBudget.toString() ?? "0.0"),
                    ),
                  ),
                  // LinearPercentIndicator(
                  //   width: 208,
                  //   animation: true,
                  //   lineHeight: 2.0,
                  //   animationDuration: 3000,
                  //   percent: (double.parse(taskController.getAllTaskModel.value?.allTaskBudget.toString() ?? "0") /
                  //       double.parse(taskController.getAllTaskModel.value?.milestone?.milestoneBudget.toString() ?? "0")),
                  //   animateFromLastPercent: true,
                  //   progressColor: AppColor.successStatusColor,
                  //   backgroundColor: AppColor.backgroundStokeColor,
                  // ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PAID OUT',
                        style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                      ),
                      Text(
                        'FUNDED',
                        style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          PopupMenuItem<String>(
            enabled: false,
            value: 'allocated_tasks',
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${taskController.getAllTaskModel.value?.allTaskBudget.toString() ?? "0"}',
                        style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                      ),
                      Image.asset(
                        AppImage.uploadFile,
                        height: 15,
                      ),
                    ],
                  ),
                  const Gap(8),
                  Text(
                    'ALLOCATED TO TASKS',
                    style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                  ),
                  const Gap(8),
                  Text(
                    'These are the funds that are already allocated to tasks in the milestone',
                    style: const TextStyle().normal14w400.textColor(AppColor.textSecondaryColor),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem<String>(
            enabled: false,
            value: 'available_allocate',
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${double.parse(taskController.getAllTaskModel.value?.milestone?.milestoneBudget.toString() ?? "0") - double.parse(taskController.getAllTaskModel.value?.allTaskBudget.toString() ?? "0")}',
                        style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                      ),
                      Image.asset(
                        AppImage.createTask,
                        height: 18,
                        color: AppColor.successStatusColor,
                      ),
                    ],
                  ),
                  const Gap(8),
                  Text(
                    'AVAILABLE TO ALLOCATE',
                    style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                  ),
                  const Gap(8),
                  Text(
                    'These are the funds that are not yet tagged to a task',
                    style: const TextStyle().normal14w400.textColor(AppColor.textSecondaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
        child: Row(
          children: [
            Text(
              "AVAILABLE",
              style: const TextStyle().normal18w400.textColor(AppColor.textSecondaryColor),
            ),
            const Gap(13),
            Image.asset(
              AppImage.info,
              height: 15,
              color: AppColor.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
