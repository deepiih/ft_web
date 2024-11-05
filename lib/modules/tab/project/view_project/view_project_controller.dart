import 'package:sectar_web/data/model/project_info.dart';
import 'package:sectar_web/package/config_packages.dart';

class ViewProjectController extends GetxController {
  RxBool isGetProjectLoading = false.obs;

  Rxn<ProjectInfo> projectInfo = Rxn<ProjectInfo>();
  RxBool isDeleteLoading = false.obs;

  Future<void> deleteProjectApi({required BuildContext context, required String projectId}) async {
    try {
      isDeleteLoading.value = true;
      var resp = await callApi(
        dio.delete(
          '${EndPoint.delete_project}/$projectId',
        ),
      );

      if (resp?.data != null) {
        if (context.mounted) {
          // Navigator.of(context).pop();
          // Navigator.of(context).pop();
          context.pop();
          context.pop();
        }
      }
      isDeleteLoading.value = false;
    } catch (e) {
      isDeleteLoading.value = false;
      debugPrint(e.toString());
    }
  }

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
}
