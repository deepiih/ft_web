import 'dart:convert';

import 'package:dio/dio.dart' as d;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sectar_web/package/config_packages.dart';

class UploadFileModel {
  String? fileName;
  XFile? file;

  UploadFileModel({this.file, this.fileName});
}

class StepTwoController extends GetxController {
  Rx<XFile>? file = XFile("").obs;
  RxList<UploadFileModel> uploadFileList =
      <UploadFileModel>[UploadFileModel(file: XFile(""), fileName: "")].obs;

  Rx<TextEditingController> mileStoneNameController =
      TextEditingController().obs;
  Rx<TextEditingController> firstMileStoneBudgetController =
      TextEditingController().obs;
  Rx<TextEditingController> startDateController = TextEditingController().obs;
  Rx<TextEditingController> endDateController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  Rx<TextEditingController> fileController = TextEditingController().obs;
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  RxList<TextEditingController> deliverableControllerList =
      <TextEditingController>[TextEditingController()].obs;
  RxBool isLoading = false.obs;
  RxBool isGetProjectLoading = false.obs;
  Rxn<ProjectInfo> projectInfo = Rxn<ProjectInfo>();

  Future<List<dynamic>> uploadFile({required String milestoneId}) async {
    try {
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.milestone_id, milestoneId));

      for (var element in uploadFileList) {
        if (element.file != null) {
          List<int> temp = await element.file!.readAsBytes();
          formData.files.add(MapEntry("attachment[]",
              d.MultipartFile.fromBytes(temp, filename: element.fileName)));
        }
      }

      var resp = await callApi(
        dio.post(
          EndPoint.upload_attachment,
          data: formData,
        ),
      );

      if (resp?.data[CommonString.status] == true) {
        List<dynamic> temp = resp?.data['filesPath'];
        for (var element in uploadFileList) {
          if (element.file == null) {
            temp.add(element.fileName);
          }
        }

        return temp;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<void> getProjectInfo({
    required String projectId,
  }) async {
    try {
      isGetProjectLoading.value = true;
      projectInfo.value = await CommonApi.getProjectInfo(projectId: projectId);
      if ((projectInfo.value?.project?.first.milestone ?? []).isNotEmpty) {
        mileStoneNameController.value.text =
            projectInfo.value?.project?.first.milestone?.first.milestoneName ??
                "";

        selectedStartDate = DateTime.parse(
            projectInfo.value?.project?.first.milestone?.first.startDate ?? "");
        startDateController.value.text =
            DateFormat(CommonDateFormat.E_d_MMMM_y).format(selectedStartDate);

        selectedEndDate = DateTime.parse(
            projectInfo.value?.project?.first.milestone?.first.endDate ?? "");
        endDateController.value.text =
            DateFormat(CommonDateFormat.E_d_MMMM_y).format(selectedEndDate);

        firstMileStoneBudgetController.value.text = projectInfo
                .value?.project?.first.milestone?.first.milestoneBudget
                .toString() ??
            "";
        descriptionController.value.text =
            projectInfo.value?.project?.first.milestone?.first.description ??
                "";

        try {
          deliverableControllerList.clear();
          List<dynamic> deliverables = jsonDecode(
              projectInfo.value?.project?.first.milestone?.first.deliverables ??
                  "");
          for (var element in deliverables) {
            deliverableControllerList.add(TextEditingController(text: element));
          }
        } catch (e) {
          if (kDebugMode) {
            print("Error decoding deliverables: $e");
          }
        }

        try {
          uploadFileList.clear();
          List<dynamic> attachments = jsonDecode(
              projectInfo.value?.project?.first.milestone?.first.attachments ??
                  '');

          for (var element in attachments) {
            uploadFileList.add(
              UploadFileModel(fileName: element),
            );
          }
        } catch (e) {
          if (kDebugMode) {
            print("Error decoding attachment: $e");
          }
        }
      }
      isGetProjectLoading.value = false;
    } catch (e) {
      isGetProjectLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> selectPdfFile(int index) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        final fileName = result.files.first.name;
        if (kIsWeb) {
          file?.value = XFile.fromData(result.files.first.bytes!);
        } else {
          file?.value = XFile(result.files.first.path!);
        }
        uploadFileList[index] =
            UploadFileModel(fileName: fileName, file: file?.value);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> createMileStone({
    required BuildContext context,
    required String projectId,
    required isFirstMilestone,
    required milestoneName,
    required milestoneBudget,
    required startDate,
    required endDate,
    required description,
    bool isFromAddMileStone = false,
    String? mileStoneId,
    required List<TextEditingController> deliverableList,
  }) async {
    GoRouter.of(context).pushNamed(GoRouterNamed.step3,
        queryParameters: {'projectId': projectId});
    // try {
    //   isLoading.value = true;
    //   d.FormData formData;
    //   formData = d.FormData();
    //
    //   if (uploadFileList.isNotEmpty) {
    //     List<dynamic> files = await uploadFile(milestoneId: mileStoneId ?? "");
    //     String tempFileJson = jsonEncode(files);
    //     formData.fields.add(MapEntry("attachment", tempFileJson));
    //   }
    //
    //   formData.fields.add(MapEntry(Param.project_id, projectId));
    //   formData.fields.add(MapEntry(Param.is_first_milestone, isFirstMilestone));
    //   formData.fields.add(MapEntry(Param.milestone_name, milestoneName));
    //   formData.fields.add(MapEntry(Param.milestone_budget, milestoneBudget));
    //   formData.fields.add(MapEntry(Param.start_date, startDate));
    //   formData.fields.add(MapEntry(Param.end_date, endDate));
    //   formData.fields.add(MapEntry(Param.description, description));
    //
    //   if ((mileStoneId ?? "").isNotEmpty) {
    //     formData.fields.add(MapEntry(Param.milestone_id, mileStoneId ?? ""));
    //   }
    //
    //   List<String> tempDeliverable = [];
    //   for (var deliverable in deliverableList) {
    //     tempDeliverable.add(deliverable.text);
    //   }
    //   String tempDeliverableJson = jsonEncode(tempDeliverable);
    //   formData.fields.add(MapEntry(Param.deliverables, tempDeliverableJson));
    //
    //   var resp = await callApi(
    //     dio.post(
    //       EndPoint.create_milestone,
    //       data: formData,
    //     ),
    //   );
    //   isLoading.value = false;
    //   if (resp?.data[CommonString.status] == true) {
    //     isLoading.value = false;
    //     showAnimationToast(
    //       context: context,
    //       isForError: !resp?.data[CommonString.status],
    //       msg: resp?.data[CommonString.message],
    //     );
    //     if (context.mounted) {
    //       if (isFromAddMileStone) {
    //         GoRouter.of(context).pushNamed(
    //           GoRouterNamed.projectDashboard,
    //           queryParameters: {
    //             'projectId': projectId,
    //           },
    //         );
    //       } else {
    //         GoRouter.of(context).pushNamed(GoRouterNamed.step3,
    //             queryParameters: {'projectId': projectId});
    //       }
    //     }
    //   } else {
    //     showAnimationToast(
    //       context: context,
    //       isForError: !resp?.data[CommonString.status],
    //       msg: resp?.data[CommonString.message],
    //     );
    //   }
    // } catch (e) {
    //   isLoading.value = false;
    //   debugPrint(e.toString());
    // }
  }
}
