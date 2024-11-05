import 'package:sectar_web/components/Dialog/sectar_popup_menu.dart';
import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final projectController = Get.put<ProjectController>(ProjectController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      projectController.getAllProjectAApi();
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ProjectController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   CommonString.homeProject,
                //   style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                // ),
                // const Gap(20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        CommonString.projects,
                        style: const TextStyle().normal24w700.textColor(AppColor.black),
                      ),
                    ),

                    ///client can not add a project
                    Visibility(
                      visible: AppPref().userType == 1 && ((projectController.getAllProjectModel.value?.projects ?? []).isNotEmpty == true && !projectController.isLoading.value),
                      child: CommonAppButton(
                        onTap: () {
                          context.pushNamed(GoRouterNamed.step1);
                        },
                        buttonType: ButtonType.enable,
                        text: CommonString.createProject,
                        width: 150,
                      ),
                    ),
                  ],
                ),
                const Gap(40),
                if ((projectController.getAllProjectModel.value?.projects ?? []).isEmpty == true && !projectController.isLoading.value) ...[
                  NoProjectOrFreelancerWidget(
                    title: CommonString.noProjectYet,
                    subTitle:
                        AppPref().userType == 2 ? "When service providers create projects\nand add you as a client, they appear here" : 'Start by creating a new project\nwith a few simple steps',
                    buttonText: AppPref().userType == 2 ? "Invite" : CommonString.createProject,
                    title1: CommonString.didYouKnow,
                    subTitle1: CommonString.sectarFasterIndustry,
                    onTap: () {
                      if (AppPref().userType == 2) {
                      } else {
                        context.pushNamed(GoRouterNamed.step1);
                      }
                    },
                  ),
                ] else ...[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Obx(() {
                            return Wrap(
                              runSpacing: 24,
                              spacing: 24,
                              children: List.generate(
                                (projectController.getAllProjectModel.value?.projects ?? []).length,
                                (index) {
                                  final String projectStatus = projectController.getAllProjectModel.value?.projects?[index].projectStatus?.toLowerCase() ?? "";
                                  return GestureDetector(
                                    onTap: () {
                                      ///============================> this is for freelancer <============================
                                      if (AppPref().userType == 1) {
                                        if (projectStatus == live.toLowerCase() || projectStatus == completed.toLowerCase()) {
                                          goToProjectDashboard(index);
                                        } else {
                                          goToDefaultView(index);
                                        }
                                      } else {
                                        ///============================> this is for client <============================

                                        if (projectStatus == live.toLowerCase() || projectStatus == completed.toLowerCase()) {
                                          goToProjectDashboard(index);
                                        } else if (projectStatus == underReview.toLowerCase() || projectStatus == changesNeeded.toLowerCase()) {
                                          goToClientReviewProject(index);
                                        } else if (projectStatus == rejected.toLowerCase()) {
                                          goToDefaultView(index);
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: Responsive.isMobile(context) ? double.infinity : 286,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: AppColor.backgroundStokeColor),
                                        color: AppColor.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 2),
                                            blurRadius: 5,
                                            color: AppColor.black.withOpacity(0.05),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(38),
                                                  color: ((projectController.getAllProjectModel.value?.projects ?? [])[index].projectColor == null)
                                                      ? Colors.orange
                                                      : HexColor.fromHex((projectController.getAllProjectModel.value?.projects ?? [])[index].projectColor.toString()),
                                                ),
                                                child: Text(
                                                  projectStatus,
                                                  style: const TextStyle().normal14w400.textColor(AppColor.white),
                                                ),
                                              ),
                                              AppPref().userType == 2
                                                  ? SectorPopupMenu(
                                                      onSelected: (val) {
                                                        if (val == CommonString.view) {
                                                          if (projectStatus == live.toLowerCase() || projectStatus == completed.toLowerCase()) {
                                                            goToProjectDashboard(index);
                                                          } else if (projectStatus == underReview.toLowerCase() || projectStatus == changesNeeded.toLowerCase()) {
                                                            goToClientReviewProject(index);
                                                          } else if (projectStatus == rejected.toLowerCase()) {
                                                            goToDefaultView(index);
                                                          }
                                                        }
                                                      },
                                                      itemList: [
                                                        PopupMenuItemModel(
                                                          value: 'view',
                                                          text: 'View',
                                                          image: AppImage.view,
                                                          imageColor: AppColor.primaryColor,
                                                        ),
                                                      ],
                                                    )
                                                  : SectorPopupMenu(
                                                      onSelected: (String choice) async {
                                                        if (choice == CommonString.edit &&
                                                            (projectStatus == draft.toLowerCase() || projectStatus == underReview.toLowerCase() || projectStatus == changesNeeded.toLowerCase())) {
                                                          GoRouter.of(context).pushNamed(
                                                            GoRouterNamed.step1,
                                                            queryParameters: {
                                                              'projectId': (projectController.getAllProjectModel.value?.projects ?? [])[index].id.toString(),
                                                            },
                                                          );
                                                        } else if (choice == CommonString.delete) {
                                                          await showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return Obx(
                                                                  () => DeleteProjectDialog(
                                                                    onTap: () {
                                                                      projectController.deleteProjectApi(
                                                                        context: context,
                                                                        projectId: (projectController.getAllProjectModel.value?.projects ?? [])[index].id.toString(),
                                                                      );
                                                                    },
                                                                    buttonType: projectController.isDeleteLoading.value ? ButtonType.progress : ButtonType.enable,
                                                                  ),
                                                                );
                                                              });
                                                        } else if (choice == CommonString.view) {
                                                          if (projectStatus == live.toLowerCase() || projectStatus == completed.toLowerCase()) {
                                                            goToProjectDashboard(index);
                                                          } else {
                                                            goToDefaultView(index);
                                                          }
                                                        }
                                                      },
                                                      itemList: [
                                                        PopupMenuItemModel(
                                                          value: 'view',
                                                          text: 'View',
                                                          image: AppImage.view,
                                                          imageColor: AppColor.textSecondaryColor,
                                                        ),
                                                        if (projectStatus == draft.toLowerCase() || projectStatus == underReview.toLowerCase() || projectStatus == changesNeeded.toLowerCase())
                                                          PopupMenuItemModel(
                                                            value: 'edit',
                                                            text: 'Edit',
                                                            image: AppImage.edit,
                                                            imageColor: AppColor.textSecondaryColor,
                                                          ),
                                                        if (projectStatus == draft.toLowerCase() ||
                                                            projectStatus == underReview.toLowerCase() ||
                                                            projectStatus == rejected.toLowerCase() ||
                                                            projectStatus == changesNeeded.toLowerCase())
                                                          PopupMenuItemModel(
                                                            value: 'delete',
                                                            text: 'Delete',
                                                            image: AppImage.delete,
                                                            imageColor: AppColor.errorStatusColor,
                                                          ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                          const Gap(15),
                                          Text(
                                            (projectController.getAllProjectModel.value?.projects ?? [])[index].projectName ?? "",
                                            style: const TextStyle().normal20w600.textColor(AppColor.lightBlackColor),
                                          ),
                                          const Gap(8),
                                          Text(
                                            AppPref().userType == 1
                                                ? (projectController.getAllProjectModel.value?.projects ?? [])[index].clientName ?? ""
                                                : (projectController.getAllProjectModel.value?.projects ?? [])[index].user?.name ?? "",
                                            style: const TextStyle().normal14w400.textColor(AppColor.textSecondaryColor),
                                          ),
                                          const Gap(10),
                                          Text(
                                            "\$ ${(projectController.getAllProjectModel.value?.projects ?? [])[index].estimatedBudget ?? ""} Estimated Budget",
                                            style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (projectController.isLoading.value) Center(child: showLoadingDialog()),
        ],
      );
    });
  }

  void goToDefaultView(int index) {
    GoRouter.of(context).pushNamed(
      GoRouterNamed.view,
      queryParameters: {
        'projectId': (projectController.getAllProjectModel.value?.projects ?? [])[index].id.toString(),
      },
    );
  }

  void goToProjectDashboard(int index) {
    GoRouter.of(context).pushNamed(
      GoRouterNamed.projectDashboard,
      queryParameters: {
        'projectId': (projectController.getAllProjectModel.value?.projects ?? [])[index].id.toString(),
      },
    );
  }

  void goToClientReviewProject(int index) {
    GoRouter.of(context).pushNamed(
      GoRouterNamed.clientReviewProject,
      queryParameters: {
        'projectId': (projectController.getAllProjectModel.value?.projects ?? [])[index].id.toString(),
      },
    );
  }
}
