import 'package:dio/dio.dart' as d;
import 'package:sectar_web/components/Dialog/project_success_dialog.dart';
import 'package:sectar_web/data/model/all_task.dart';
import 'package:sectar_web/data/model/milestone_model.dart';
import 'package:sectar_web/data/model/project_model.dart';

import '../../../../package/config_packages.dart';

class TaskController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isGetTaskLoading = false.obs;
  RxBool isTaskChangesLoading = false.obs;
  RxBool isDeleteTaskLoading = false.obs;
  RxBool isApproveTaskLoading = false.obs;
  Rxn<GetAllTaskModel> getAllTaskModel = Rxn<GetAllTaskModel>();
  RxDouble availableBudget = 0.0.obs;

  Future<void> closeProject({
    required BuildContext context,
    required String projectId,
  }) async {
    try {
      isLoading.value = true;
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.project_id, projectId));

      var resp = await callApi(
        dio.post(
          EndPoint.complete_project,
          data: formData,
        ),
      );
      isLoading.value = false;
      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          showAnimationToast(
            context: context,
            isForError: !resp?.data[CommonString.status],
            msg: resp?.data[CommonString.message],
          );
          Navigator.of(context).pop();
        }
        // await getAllTaskApi(mid: mileStoneId.toString());
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

  Future<void> closeMilestone({
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
          EndPoint.complete_milestone,
          data: formData,
        ),
      );
      isLoading.value = false;
      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          showAnimationToast(
            context: context,
            isForError: !resp?.data[CommonString.status],
            msg: resp?.data[CommonString.message],
          );
          Navigator.of(context).pop();
        }
        await getAllTaskApi(mid: mileStoneId.toString());
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

  Future<void> refundMilestone({
    required BuildContext context,
    required String reason,
    mileStoneId,
  }) async {
    try {
      isLoading.value = true;
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.milestone_id, mileStoneId));
      formData.fields.add(MapEntry(Param.refund_amount, reason));

      var resp = await callApi(
        dio.post(
          EndPoint.refund_milestone,
          data: formData,
        ),
      );
      isLoading.value = false;

      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          showAnimationToast(
            context: context,
            isForError: !resp?.data[CommonString.status],
            msg: resp?.data[CommonString.message],
          );
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (context) {
                return ProjectSuccessDialog(
                  titleText: "We will process the refund shortly",
                  displayText: "Once there is an update, we will email you.\nIt typically takes 2-3 days to process \nthe refund.",
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                );
              });
        }
        await getAllTaskApi(mid: mileStoneId.toString());
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

  Future<void> disputeMilestone({
    required BuildContext context,
    required String reason,
    mileStoneId,
  }) async {
    try {
      isLoading.value = true;
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.milestone_id, mileStoneId));
      formData.fields.add(MapEntry(Param.dispute_reason, reason));

      var resp = await callApi(
        dio.post(
          EndPoint.dispute_milestone,
          data: formData,
        ),
      );
      isLoading.value = false;

      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          showAnimationToast(
            context: context,
            isForError: !resp?.data[CommonString.status],
            msg: resp?.data[CommonString.message],
          );
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (context) {
                return ProjectSuccessDialog(
                  titleText: "We got your request and hope this\nisn’t too bad for you",
                  displayText: "We will reach out to you and the service\nprovider to find a amicable resolution.\nPlease note that we are here with you\nhrough the process.",
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                );
              });
        }
        await getAllTaskApi(mid: mileStoneId.toString());
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

  Future<void> approveTaskApi({
    required BuildContext context,
    required String taskId,
    mileStoneId,
  }) async {
    try {
      isApproveTaskLoading.value = true;
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.task_id, taskId));

      var resp = await callApi(
        dio.post(
          EndPoint.approve_task,
          data: formData,
        ),
      );
      isApproveTaskLoading.value = false;

      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          showAnimationToast(
            context: context,
            isForError: !resp?.data[CommonString.status],
            msg: resp?.data[CommonString.message],
          );
        }
        await getAllTaskApi(mid: mileStoneId.toString());
      } else {
        showAnimationToast(
          context: context,
          isForError: !resp?.data[CommonString.status],
          msg: resp?.data[CommonString.message],
        );
      }
    } catch (e) {
      isApproveTaskLoading.value = false;
      debugPrint(e.toString());
    }
  }

  ///task-change-request
  Future<void> taskChangeRequest({
    required BuildContext context,
    required String taskId,
    mileStoneId,
    required String taskChangesNote,
  }) async {
    try {
      isTaskChangesLoading.value = true;
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.task_id, taskId));
      formData.fields.add(MapEntry(Param.task_change_notes, taskChangesNote));

      var resp = await callApi(
        dio.post(
          EndPoint.task_change_request,
          data: formData,
        ),
      );
      isTaskChangesLoading.value = false;

      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          showAnimationToast(
            context: context,
            isForError: !resp?.data[CommonString.status],
            msg: resp?.data[CommonString.message],
          );
        }
        await getAllTaskApi(mid: mileStoneId.toString());
      } else {
        showAnimationToast(
          context: context,
          isForError: !resp?.data[CommonString.status],
          msg: resp?.data[CommonString.message],
        );
      }
    } catch (e) {
      isTaskChangesLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> createTaskApi({
    required BuildContext context,
    String? taskName,
    description,
    mileStoneId,
    taskBudget,
    taskStatus,
    dueDate,
    String? taskId,
  }) async {
    try {
      isLoading.value = true;
      d.FormData formData;
      formData = d.FormData();

      ///this is from edit task
      if ((taskId ?? "").isNotEmpty) {
        formData.fields.add(MapEntry(Param.task_id, taskId ?? ""));
      }

      // if ((taskId ?? "").isEmpty) {
      formData.fields.add(MapEntry(Param.task_name, taskName ?? ""));
      formData.fields.add(MapEntry(Param.description, description));
      // }
      formData.fields.add(MapEntry(Param.milestone_id, mileStoneId.toString()));

      formData.fields.add(MapEntry(Param.due_date, dueDate));
      formData.fields.add(MapEntry(Param.task_budget, taskBudget.toString()));
      formData.fields.add(MapEntry(Param.task_status, taskStatus));

      var resp = await callApi(
        dio.post(
          EndPoint.create_task,
          data: formData,
        ),
      );
      if (resp?.data[CommonString.status] == true) {
        isLoading.value = false;
        if (context.mounted) {
          Navigator.pop(context);
          if (context.mounted) {
            showAnimationToast(
              context: context,
              isForError: !resp?.data[CommonString.status],
              msg: resp?.data[CommonString.message],
            );
          }
        }

        await getAllTaskApi(mid: mileStoneId.toString());
      } else {
        if (context.mounted) {
          showAnimationToast(
            context: context,
            isForError: !resp?.data[CommonString.status],
            msg: resp?.data[CommonString.message],
          );
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> changeTaskStatusApi({
    required BuildContext context,
    required String taskId,
    required String taskStatus,
    required String mileStoneId,
  }) async {
    try {
      isGetTaskLoading.value = true;
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.task_id, taskId));
      formData.fields.add(MapEntry(Param.task_status, taskStatus));

      var resp = await callApi(
        dio.post(
          EndPoint.change_task_status,
          data: formData,
        ),
      );
      isGetTaskLoading.value = false;

      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          Navigator.pop(context);
          showAnimationToast(
            isForError: !resp?.data[CommonString.status],
            context: context,
            msg: resp?.data[CommonString.message],
          );
        }
        await getAllTaskApi(mid: mileStoneId.toString());
      } else {
        showAnimationToast(
          context: context,
          isForError: !resp?.data[CommonString.status],
          msg: resp?.data[CommonString.message],
        );
      }
    } catch (e) {
      isGetTaskLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> changeTaskPaymentStatusApi({
    required BuildContext context,
    required String taskId,
    required String taskPaymentStatus,
  }) async {
    try {
      isLoading.value = true;
      d.FormData formData;
      formData = d.FormData();
      formData.fields.add(MapEntry(Param.task_id, taskId));
      formData.fields.add(MapEntry(Param.task_payment_status, taskPaymentStatus));

      var resp = await callApi(
        dio.post(
          EndPoint.task_update_payment_status,
          data: formData,
        ),
      );
      isLoading.value = false;

      if (resp?.data[CommonString.status] == true) {
        isLoading.value = false;
        if (context.mounted) {
          Navigator.pop(context);

          if (context.mounted) {
            showAnimationToast(
              context: context,
              isForError: !resp?.data[CommonString.status],
              msg: resp?.data[CommonString.message],
            );
          }
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

  Future<void> getAllTaskApi({required String mid}) async {




    availableBudget.value = double.parse(getAllTaskModel.value?.milestone?.milestoneBudget.toString() ?? "0") - double.parse(getAllTaskModel.value?.allTaskBudget.toString() ?? "0");

  }

  Future<void> deleteTaskApi({required BuildContext context, required String id, mileStoneId}) async {
    try {
      isDeleteTaskLoading.value = true;
      var resp = await callApi(
        dio.delete(
          "${EndPoint.delete_task}/$id",
        ),
      );
      isDeleteTaskLoading.value = false;
      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
          showAnimationToast(
            isForError: !resp?.data[CommonString.status],
            context: context,
            msg: resp?.data[CommonString.message],
          );
          await getAllTaskApi(mid: mileStoneId.toString());
        }
      } else {
        showAnimationToast(
          context: context,
          isForError: !resp?.data[CommonString.status],
          msg: resp?.data[CommonString.message],
        );
      }
    } catch (e) {
      isDeleteTaskLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
