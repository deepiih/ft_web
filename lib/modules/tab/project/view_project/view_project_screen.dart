import 'package:sectar_web/components/Dialog/delete_project_dialog.dart';
import 'package:sectar_web/package/config_packages.dart';

import '../client/client_project_review_controller.dart';

class ViewProjectScreen extends StatefulWidget {
  const ViewProjectScreen({super.key, this.projectId, this.milestoneId});

  final String? projectId;
  final String? milestoneId;

  @override
  State<ViewProjectScreen> createState() => _ViewProjectScreenState();
}

class _ViewProjectScreenState extends State<ViewProjectScreen> {
  final clientProjectReviewController =
      Get.put<ClientProjectReviewController>(ClientProjectReviewController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      clientProjectReviewController.getProjectInfo(context,
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
    return Obx(() {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: AppColor.white,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(0.0),
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
                        //   'Home > View',
                        //   style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                        // ),
                        CloseTextButton(),
                      ],
                    ),
                  ),
                  const Gap(28),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.isDesktop(context) ? 0 : 20),
                      child: SizedBox(
                        width: Responsive.isDesktop(context)
                            ? MediaQuery.of(context).size.width / 3.5
                            : double.infinity,
                        child: ((widget.milestoneId ?? "").isNotEmpty)
                            ? _milestoneInfo()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _projectInfo(),
                                  const Gap(24),
                                  _editDeleteProjectInfo(),
                                ],
                              ),
                      ),
                    ),
                  ),
                  const Gap(28),
                ],
              ),
            ),
          ),
          if (clientProjectReviewController.isGetProjectLoading.value)
            Center(child: showLoadingDialog()),
        ],
      );
    });
  }

  GestureDetector _viewProjectClientSide() {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).goNamed(
          'project/reviewproject',
          queryParameters: {
            'projectId': (clientProjectReviewController
                .projectInfo.value?.project?.first.id
                .toString()),
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.backgroundStokeColor)),
            child: Row(
              children: [
                Image.asset(
                  AppImage.createProject,
                  height: 20,
                  color: AppColor.primaryColor,
                ),
                const Gap(8),
                Text(
                  "View Project",
                  textAlign: TextAlign.center,
                  style: const TextStyle()
                      .normal16w400
                      .textColor(AppColor.lightBlackColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _editDeleteProjectInfo() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColor.backgroundStokeColor,
                width: 0.9,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImage.createProject,
                  color: AppColor.primaryColor,
                  height: 32,
                ),
                const Gap(32),
                Text(
                  "Project name",
                  textAlign: TextAlign.center,
                  style: const TextStyle()
                      .normal24w700
                      .textColor(AppColor.lightBlackColor),
                ),
                const Gap(8),
                Text(
                  "${"Client name •"} Created on ${DateFormat(CommonDateFormat.E_d_MMMM_y).format(DateTime.now())}",
                  textAlign: TextAlign.center,
                  style: const TextStyle()
                      .normal16w400
                      .textColor(AppColor.lightBlackColor),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).goNamed(
                          GoRouterNamed.step1,
                          queryParameters: {
                            'projectId': clientProjectReviewController
                                    .projectInfo.value?.project?.first.id
                                    .toString() ??
                                "",
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColor.backgroundStokeColor)),
                        child: Row(
                          children: [
                            Image.asset(
                              AppImage.edit,
                              height: 20,
                            ),
                            const Gap(8),
                            Text(
                              "Edit Project",
                              textAlign: TextAlign.center,
                              style: const TextStyle()
                                  .normal16w400
                                  .textColor(AppColor.lightBlackColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Gap(16),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Obx(
                                    () => DeleteProjectDialog(
                                      onTap: () {
                                        clientProjectReviewController
                                            .deleteProjectApi(
                                          context: context,
                                          projectId:
                                              clientProjectReviewController
                                                      .projectInfo
                                                      .value
                                                      ?.project
                                                      ?.first
                                                      .id
                                                      .toString() ??
                                                  "",
                                        );
                                      },
                                      buttonType: clientProjectReviewController
                                              .isDeleteLoading.value
                                          ? ButtonType.progress
                                          : ButtonType.enable,
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColor.backgroundStokeColor)),
                            child: Row(
                              children: [
                                Image.asset(
                                  AppImage.delete,
                                  height: 20,
                                  color: AppColor.errorStatusColor,
                                ),
                                const Gap(8),
                                Text(
                                  "Delete",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle()
                                      .normal16w400
                                      .textColor(AppColor.lightBlackColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _editDeleteMilestoneInfo() {
    String? milestoneStatus = clientProjectReviewController
        .milestoneInfo.value?.milestoneStatus
        ?.toLowerCase();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: milestoneStatus == completed.toLowerCase(),
          child: InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.backgroundStokeColor)),
              child: Row(
                children: [
                  Text(
                    "Done",
                    textAlign: TextAlign.center,
                    style: const TextStyle()
                        .normal16w400
                        .textColor(AppColor.lightBlackColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: AppPref().userType == 1 &&
              (milestoneStatus == draft.toLowerCase() ||
                  milestoneStatus == underReview.toLowerCase() ||
                  milestoneStatus == changesNeeded.toLowerCase()),
          child: InkWell(
            onTap: () {
              GoRouter.of(context).goNamed(
                GoRouterNamed.step1,
                queryParameters: {
                  'projectId': clientProjectReviewController
                          .projectInfo.value?.project?.first.id
                          .toString() ??
                      "",
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.backgroundStokeColor)),
              child: Row(
                children: [
                  Image.asset(
                    AppImage.edit,
                    height: 20,
                  ),
                  const Gap(8),
                  Text(
                    "Edit Project",
                    textAlign: TextAlign.center,
                    style: const TextStyle()
                        .normal16w400
                        .textColor(AppColor.lightBlackColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: AppPref().userType == 1 &&
              (milestoneStatus == draft.toLowerCase() ||
                  milestoneStatus == underReview.toLowerCase() ||
                  milestoneStatus == rejected.toLowerCase() ||
                  milestoneStatus == changesNeeded.toLowerCase()),
          child: Row(
            children: [
              const Gap(16),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Obx(
                          () => DeleteProjectDialog(
                            title: "Delete milestone",
                            subTitle:
                                "Are you sure you want to delete this\nmilestone? This can’t be undone.",
                            buttonText: "Delete milestone",
                            onTap: () {
                              clientProjectReviewController.deleteMilestoneApi(
                                context: context,
                                milestoneId: clientProjectReviewController
                                        .milestoneInfo.value?.id
                                        .toString() ??
                                    "",
                                projectId: clientProjectReviewController
                                        .projectInfo.value?.project?.first.id
                                        .toString() ??
                                    "",
                              );
                            },
                            buttonType: clientProjectReviewController
                                    .isDeleteLoading.value
                                ? ButtonType.progress
                                : ButtonType.enable,
                          ),
                        );
                      });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.backgroundStokeColor)),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImage.delete,
                        height: 20,
                        color: AppColor.errorStatusColor,
                      ),
                      const Gap(8),
                      Text(
                        "Delete",
                        textAlign: TextAlign.center,
                        style: const TextStyle()
                            .normal16w400
                            .textColor(AppColor.lightBlackColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _projectInfo() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColor.navigationRailColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColor.backgroundStokeColor,
                width: 0.9,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  getStatusImage(status: "Draft") ?? "",
                  height: 20,
                ),
                const Gap(20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF2949F4),
                  ),
                  child: Text(
                    "Draft",
                    textAlign: TextAlign.center,
                    style: const TextStyle()
                        .normal16w400
                        .textColor(AppColor.white),
                  ),
                ),
                const Gap(24),
                Text(
                  "The project is still under draft. Please add first milestone details and other info to send it for review to the client.",
                  textAlign: TextAlign.center,
                  style: const TextStyle()
                      .normal18w400
                      .textColor(AppColor.lightBlackColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _milestoneInfo() {
    String? milestoneStatus = clientProjectReviewController
        .milestoneInfo.value?.milestoneStatus
        ?.toLowerCase();
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColor.navigationRailColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColor.backgroundStokeColor,
                width: 0.9,
              ),
            ),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: (milestoneStatus != null),
                    child: Image.asset(
                      getStatusImage(status: milestoneStatus ?? "") ?? "",
                      height: 25,
                    ),
                  ),
                  const Gap(20),
                  if (clientProjectReviewController.milestoneInfo.value != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: HexColor.fromHex(
                          (clientProjectReviewController
                                  .milestoneInfo.value?.milestoneColor ??
                              ""),
                        ),
                      ),
                      child: Text(
                        milestoneStatus?.capitalizeFirst ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle()
                            .normal16w400
                            .textColor(AppColor.white),
                      ),
                    ),
                  const Gap(18),
                  Text(
                    milestoneStatus == null ? "" : "Milestone Update",
                    textAlign: TextAlign.center,
                    style: const TextStyle()
                        .normal20w700
                        .textColor(AppColor.black),
                  ),
                  const Gap(24),
                  Text(
                    getMilestoneStatusContent(
                            milestoneStatus ?? "",
                            clientProjectReviewController
                                    .projectInfo
                                    .value
                                    ?.project
                                    ?.first
                                    .clientName
                                    ?.capitalizeFirst ??
                                "",
                            clientProjectReviewController.projectInfo.value
                                    ?.userName?.capitalizeFirst ??
                                "",
                            date: clientProjectReviewController
                                .milestoneInfo.value?.updatedAt) ??
                        "",
                    textAlign: TextAlign.center,
                    style: const TextStyle()
                        .normal18w400
                        .textColor(AppColor.lightBlackColor),
                  ),
                  const Gap(18),
                  _editDeleteMilestoneInfo()
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
