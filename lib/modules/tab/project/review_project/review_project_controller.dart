import 'package:dio/dio.dart' as d;
import 'package:sectar_web/components/Dialog/project_success_dialog.dart';
import 'package:sectar_web/data/model/project_info.dart';
import 'package:sectar_web/modules/tab/project/project_controller.dart';

import '../../../../package/config_packages.dart';

class ReviewProjectController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isGetProjectLoading = false.obs;
  Rxn<ProjectInfo> projectInfo = Rxn<ProjectInfo>();

  Future<void> getProjectInfo({
    required String projectId,
  }) async {
    try {
      isGetProjectLoading.value = true;
      projectInfo.value = await CommonApi.getProjectInfo(projectId: projectId);
      isGetProjectLoading.value = false;
    } catch (e) {
      isGetProjectLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> sendForReviewApi({
    required BuildContext context,
    required String projectId,
  }) async {
    Get.find<ProjectController>().getAllProjectAApi();
    Navigator.pop(context);
    GoRouter.of(context).goNamed(GoRouterNamed.project);
    // try {
    //   isLoading.value = true;
    //   d.FormData formData;
    //   formData = d.FormData();
    //   formData.fields.add(MapEntry(Param.project_id, projectId));
    //
    //   var resp = await callApi(
    //     dio.post(
    //       EndPoint.send_for_review,
    //       data: formData,
    //     ),
    //   );
    //   if (resp?.data[CommonString.status] == true) {
    //     if (context.mounted) {
    //       Navigator.pop(context);
    //       showDialog(
    //           context: context,
    //           builder: (context) {
    //             return ProjectSuccessDialog(
    //               titleText:
    //                   "Woohoo! The project is sent for\nclient review and funding",
    //               displayText:
    //                   "A copy of the email is also sent to you for\nclarity. We will update you whenever\nthere is an update from the client. ",
    //               onTap: () {
    //                 Get.find<ProjectController>().getAllProjectAApi();
    //                 Navigator.pop(context);
    //                 GoRouter.of(context).goNamed(GoRouterNamed.project);
    //               },
    //             );
    //           });
    //     }
    //   } else {
    //     if (context.mounted) {
    //       Navigator.of(context).pop();
    //
    //       showAnimationToast(
    //           context: context,
    //           msg: resp?.data[CommonString.message],
    //           isForError: !resp?.data[CommonString.status]);
    //     }
    //   }
    //
    //   isLoading.value = false;
    // } catch (e) {
    //   isLoading.value = false;
    //   debugPrint(e.toString());
    // }
  }
}
