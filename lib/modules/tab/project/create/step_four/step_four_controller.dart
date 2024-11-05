import 'package:dio/dio.dart' as d;
import 'package:sectar_web/data/model/project_info.dart';
import 'package:sectar_web/package/config_packages.dart';

class StepFourController extends GetxController {
  Rx<TextEditingController> clientNameController = TextEditingController().obs;
  Rx<TextEditingController> clientEmailController = TextEditingController().obs;

  RxBool isLoading = false.obs;
  RxBool isGetProjectLoading = false.obs;

  Rxn<ProjectInfo> projectInfo = Rxn<ProjectInfo>();

  Future<void> getProjectInfo({
    required String projectId,
  }) async {
    try {
      isGetProjectLoading.value = true;
      projectInfo.value = await CommonApi.getProjectInfo(projectId: projectId);
      clientNameController.value.text =
          projectInfo.value?.project?.first.clientName ?? "";
      clientEmailController.value.text =
          projectInfo.value?.project?.first.clientEmail ?? "";
      isGetProjectLoading.value = false;
    } catch (e) {
      isGetProjectLoading.value = false;

      debugPrint(e.toString());
    }
  }

  Future<void> addProjectClientApi({
    required BuildContext context,
    required String clientName,
    required String clientEmail,
    required String projectId,
  }) async {
    // try {
    //   isLoading.value = true;
    //   d.FormData formData;
    //   formData = d.FormData();
    //
    //   formData.fields.add(MapEntry(Param.project_id, projectId));
    //   formData.fields.add(MapEntry(Param.client_name, clientName));
    //   formData.fields.add(MapEntry(Param.client_email, clientEmail));
    //
    //   var resp = await callApi(
    //     dio.post(
    //       EndPoint.project_add_client,
    //       data: formData,
    //     ),
    //   );
    //   if (resp?.data[CommonString.status] == true) {
    //     isLoading.value = false;
    //     if (context.mounted) {
          GoRouter.of(context).pushNamed(GoRouterNamed.reviewProject,
              queryParameters: {'projectId': projectId});
    //     }
    //   }
    //   isLoading.value = false;
    // } catch (e) {
    //   isLoading.value = false;
    //   debugPrint(e.toString());
    // }
  }
}
