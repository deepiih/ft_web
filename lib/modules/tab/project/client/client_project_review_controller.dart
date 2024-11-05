import 'package:dio/dio.dart' as d;

import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

class ClientProjectReviewController extends GetxController {
  Rxn<ProjectInfo> projectInfo = Rxn<ProjectInfo>();
  Rxn<Milestone> milestoneInfo = Rxn<Milestone>();
  RxBool isLoading = false.obs;
  RxBool isGetProjectLoading = false.obs;
  RxBool isDeleteLoading = false.obs;

  RxList<AutoPay> autoPayList = [
    AutoPay(
      title: "01 Day",
      isSelected: false,
    ),
    AutoPay(
      title: "03 Days",
      isSelected: true,
    ),
    AutoPay(
      title: "05 Days",
      isSelected: false,
    ),
    AutoPay(
      title: "07 Days",
      isSelected: false,
    ),
    AutoPay(
      title: "10 Days",
      isSelected: false,
    ),
  ].obs;

  RxString selectedAUTOPAY = "03 Days".obs;

  Future<void> getMilestoneInfo({
    required String milestoneId,
  }) async {
    try {
      var resp = await callApi(
        dio.get(
          '${EndPoint.get_milestone}/$milestoneId',
        ),
      );
      if (resp?.data[CommonString.status] == true) {
        milestoneInfo.value = Milestone.fromJson(resp?.data['milestone']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return;
  }

  Future<void> approveMilestone({
    required BuildContext context,
    required String mileStoneId,
  }) async {
    try {
      isLoading.value = true;
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.milestone_id, mileStoneId));

      var resp = await callApi(
        dio.post(
          EndPoint.approve_milestone,
          data: formData,
        ),
      );
      isLoading.value = false;
      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          Navigator.of(context).pop();
          _launchInWebView(
            Uri.parse(
              resp?.data['payment_url'],
            ),
          );
        }
      } else {
        showAnimationToast(
          context: context,
          isForError: !resp?.data[CommonString.status],
          msg: resp?.data[CommonString.message],
        );
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> rejectMileStone({
    required BuildContext context,
    required String mileStoneId,
  }) async {
    try {
      isLoading.value = true;
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.milestone_id, mileStoneId));
      var resp = await callApi(
        dio.post(
          EndPoint.reject_milestone,
          data: formData,
        ),
      );
      isLoading.value = false;

      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (context) {
                return CommonDialog(
                  buttonType: ButtonType.enable,
                  isViewCenter: true,
                  leftSideIcon: AppImage.delete,
                  leftSideIconColor: AppColor.errorStatusColor,
                  title: "Milestone is rejected",
                  content1: "For any queries, please write to us as",
                  content2: '\nsupport.sectar.co',
                  buttonText: "Done",
                  buttonColor: AppColor.successStatusColor,
                  buttonTap: () async {
                    await Get.find<ProjectController>().getAllProjectAApi();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      GoRouter.of(context).go(GoRouterPath.project);
                    }
                  },
                );
              });
        }
      } else {
        showAnimationToast(
          context: context,
          isForError: !resp?.data[CommonString.status],
          msg: resp?.data[CommonString.message],
        );
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> requestChangesMilestone({
    required BuildContext context,
    required String milestoneId,
    required String changes,
  }) async {
    try {
      isLoading.value = true;
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.milestone_id, milestoneId));
      formData.fields.add(MapEntry(Param.change_notes, changes));
      var resp = await callApi(
        dio.post(
          EndPoint.milestone_change_request,
          data: formData,
        ),
      );
      isLoading.value = false;
      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (context) {
                return ProjectSuccessDialog(
                  titleText: "The milestone is sent to the vendor for changes",
                  displayText: "A copy of the email is also sent to you for\nclarity. We will update you\nwhenever there is an update.",
                  onTap: () {
                    Navigator.of(context).pop();

                    GoRouter.of(context).go(GoRouterPath.project);
                  },
                );
              });
        }
      } else {
        showAnimationToast(
          context: context,
          isForError: !resp?.data[CommonString.status],
          msg: resp?.data[CommonString.message],
        );
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> getProjectInfo(
    BuildContext context, {
    required String projectId,
  }) async {
    try {
      isGetProjectLoading.value = true;
      projectInfo.value = await CommonApi.getProjectInfo(projectId: projectId);

      String selectedAutoPay = projectInfo.value?.project?.first.autoPayDays == null ? "3" : projectInfo.value?.project?.first.autoPayDays.toString() ?? "1";
      if (selectedAutoPay == "1") {
        selectedAUTOPAY.value = '${selectedAutoPay.padLeft(2, '0')} Day';
      } else {
        selectedAUTOPAY.value = '${selectedAutoPay.padLeft(2, '0')} Days';
      }

      isGetProjectLoading.value = false;
    } catch (e) {
      isGetProjectLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> rejectProjectApi({
    required BuildContext context,
    required String projectId,
  }) async {
    try {
      isLoading.value = true;
      var resp = await callApi(
        dio.post(EndPoint.reject_project, queryParameters: {'project_id': projectId}),
      );
      isLoading.value = false;

      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (context) {
                return CommonDialog(
                  buttonType: ButtonType.enable,
                  isViewCenter: true,
                  leftSideIcon: AppImage.delete,
                  leftSideIconColor: AppColor.errorStatusColor,
                  title: "Project is rejected",
                  content1: "For any queries, please write to us as",
                  content2: '\nsupport.sectar.co',
                  buttonText: "Done",
                  buttonColor: AppColor.successStatusColor,
                  buttonTap: () async {
                    await Get.find<ProjectController>().getAllProjectAApi();
                    if (context.mounted) {
                      Navigator.of(context).pop();

                      GoRouter.of(context).go(GoRouterPath.project);
                    }
                  },
                );
              });
        }
      } else {
        showAnimationToast(
          context: context,
          isForError: !resp?.data[CommonString.status],
          msg: resp?.data[CommonString.message],
        );
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> requestChangesProjectApi({
    required BuildContext context,
    required String projectId,
    required String changes,
  }) async {
    try {
      isLoading.value = true;
      var resp = await callApi(
        dio.post(EndPoint.request_chanage, queryParameters: {
          'project_id': projectId,
          'project_changes': changes,
        }),
      );
      isLoading.value = false;

      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (context) {
                return ProjectSuccessDialog(
                  titleText: "The project is sent to the vendor for changes",
                  displayText: "A copy of the email is also sent to you for\nclarity. We will update you\nwhenever there is an update.",
                  onTap: () {
                    Navigator.of(context).pop();

                    GoRouter.of(context).go(GoRouterPath.project);
                  },
                );
              });
        }
      } else {
        showAnimationToast(
          context: context,
          isForError: !resp?.data[CommonString.status],
          msg: resp?.data[CommonString.message],
        );
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> approveProjectApi({
    required BuildContext context,
    required String projectId,
    required String autoPay,
  }) async {
    try {
      isLoading.value = true;
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.project_id, projectId));
      formData.fields.add(MapEntry(Param.auto_pay_days, int.parse(autoPay.split(' ').first).toString()));

      var resp = await callApi(
        dio.post(
          EndPoint.approve_project,
          data: formData,
        ),
      );
      isLoading.value = false;
      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          Navigator.of(context).pop();
          _launchInWebView(
            Uri.parse(
              resp?.data['payment_url'],
            ),
          );
          /*     showDialog(
              context: context,
              builder: (context) {
                return CommonDialog(
                  buttonType: ButtonType.enable,
                  isViewCenter: true,
                  leftSideIcon: AppImage.right,
                  leftSideIconColor: AppColor.successStatusColor,
                  title: "The project is live. Congrats.",
                  content1:
                      "We wish you happy and productive work\nwith this project. For any queries,\nplease write to us as",
                  content2: '\nsupport.sectar.co',
                  buttonText: "Okay",
                  buttonColor: AppColor.successStatusColor,
                  buttonTap: () {
                    Navigator.of(context).pop();

                    GoRouter.of(context).go(GoRouterPath.project);
                  },
                );
              });*/
        }
      } else {
        showAnimationToast(
          context: context,
          isForError: !resp?.data[CommonString.status],
          msg: resp?.data[CommonString.message],
        );
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> deleteProjectApi({required BuildContext context, required String projectId}) async {
    try {
      isDeleteLoading.value = true;
      var resp = await callApi(
        dio.delete(
          '${EndPoint.delete_project}/$projectId',
        ),
      );
      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          Get.find<ProjectController>().getAllProjectAApi();
          context.pop();
          context.pop();
        }
      } else {
        showAnimationToast(
          context: context,
          isForError: !resp?.data[CommonString.status],
          msg: resp?.data[CommonString.message],
        );
      }
      isDeleteLoading.value = false;
    } catch (e) {
      isDeleteLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> deleteMilestoneApi({required BuildContext context, required String milestoneId, required String projectId}) async {
    try {
      isDeleteLoading.value = true;
      var resp = await callApi(
        dio.delete(
          '${EndPoint.delete_milestone}/$milestoneId',
        ),
      );
      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          Get.find<ProjectController>().getAllProjectAApi();
          Get.find<ProjectDashController>().getProjectInfo(projectId: projectId);
          context.pop();
          context.pop();
        }
      } else {
        showAnimationToast(
          context: context,
          isForError: !resp?.data[CommonString.status],
          msg: resp?.data[CommonString.message],
        );
      }
      isDeleteLoading.value = false;
    } catch (e) {
      isDeleteLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      // webOnlyWindowName: '_self',
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
