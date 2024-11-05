import 'package:dio/dio.dart' as d;
import 'package:sectar_web/data/model/project_info.dart';
import 'package:sectar_web/package/config_packages.dart';

class StepThreeController extends GetxController {
  Rx<TextEditingController> noteController = TextEditingController().obs;

  RxBool isLoading = false.obs;
  RxBool isGetProjectLoading = false.obs;

  Rxn<ProjectInfo> projectInfo = Rxn<ProjectInfo>();

  Future<void> getProjectInfo({
    required String projectId,
  }) async {
    try {
      isGetProjectLoading.value = true;
      projectInfo.value = await CommonApi.getProjectInfo(projectId: projectId);
      noteController.value.text =
          projectInfo.value?.project?.first.projectNotes ?? "";

      isGetProjectLoading.value = false;
    } catch (e) {
      isGetProjectLoading.value = false;

      debugPrint(e.toString());
    }
  }

  Future<void> saveProjectNoteApi({
    required BuildContext context,
    required String projectId,
    required String note,
  }) async {
    GoRouter.of(context).pushNamed(GoRouterNamed.step4,
        queryParameters: {'projectId': projectId});
    // try {
    //   isLoading.value = true;
    //   d.FormData formData;
    //   formData = d.FormData();
    //
    //   formData.fields.add(MapEntry(Param.project_id, projectId));
    //   formData.fields.add(MapEntry(Param.project_notes, note));
    //
    //   var resp = await callApi(
    //     dio.post(
    //       EndPoint.save_project_notes,
    //       data: formData,
    //     ),
    //   );
    //   if (resp?.data[CommonString.status] == true) {
    //     isLoading.value = false;
    //     if (context.mounted) {
    //       GoRouter.of(context).pushNamed(GoRouterNamed.step4,
    //           queryParameters: {'projectId': projectId});
    //     }
    //   }
    //   isLoading.value = false;
    // } catch (e) {
    //   isLoading.value = false;
    //   debugPrint(e.toString());
    // }
  }
}
