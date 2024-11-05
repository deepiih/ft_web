import 'package:sectar_web/data/model/milestone_model.dart';
import 'package:sectar_web/data/model/project_model.dart';

class GetAllTaskModel {
  bool? status;
  Project? project;
  Milestone? milestone;
  var allTaskBudget;
  var paidOutFunds;
  List<Tasks>? tasks;
  String? message;

  GetAllTaskModel(
      {this.status,
      this.project,
      this.milestone,
      this.allTaskBudget,
      this.tasks,
      this.message,
      this.paidOutFunds});

  GetAllTaskModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    project =
        json['project'] != null ? new Project.fromJson(json['project']) : null;
    milestone = json['milestone'] != null
        ? new Milestone.fromJson(json['milestone'])
        : null;
    allTaskBudget = json['all_task_budget'];
    paidOutFunds = json['paid_out_funds'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    if (this.milestone != null) {
      data['milestone'] = this.milestone!.toJson();
    }
    data['all_task_budget'] = this.allTaskBudget;
    data['paid_out_funds'] = this.paidOutFunds;
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Tasks {
  String? title;
  List<Task>? tasks;
  var taskTotal;
  String? color;

  Tasks({this.title, this.tasks, this.taskTotal, this.color});

  Tasks.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    if (json['Tasks'] != null) {
      tasks = <Task>[];
      json['Tasks'].forEach((v) {
        tasks!.add(new Task.fromJson(v));
      });
    }
    taskTotal = json['TaskTotal'];
    color = json['Color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    if (this.tasks != null) {
      data['Tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    data['TaskTotal'] = this.taskTotal;
    data['Color'] = this.color;
    return data;
  }
}

class Task {
  int? id;
  int? milestoneId;
  String? taskName;
  String? description;
  String? dueDate;
  String? taskStatus;
  String? autoPayDate;
  int? taskBudget;
  String? taskPaymentStatus;
  String? taskColor;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Task(
      {this.id,
      this.milestoneId,
      this.taskName,
      this.description,
      this.dueDate,
      this.taskStatus,
      this.autoPayDate,
      this.taskBudget,
      this.taskPaymentStatus,
      this.taskColor,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    milestoneId = json['milestone_id'];
    taskName = json['task_name'];
    description = json['description'];
    dueDate = json['due_date'];
    autoPayDate = json['autopay_date'];
    taskStatus = json['task_status'];
    taskBudget = json['task_budget'];
    taskPaymentStatus = json['task_payment_status'];
    taskColor = json['task_color'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['autopay_date'] = this.autoPayDate;
    data['id'] = this.id;
    data['milestone_id'] = this.milestoneId;
    data['task_name'] = this.taskName;
    data['description'] = this.description;
    data['due_date'] = this.dueDate;
    data['task_status'] = this.taskStatus;
    data['task_budget'] = this.taskBudget;
    data['task_payment_status'] = this.taskPaymentStatus;
    data['task_color'] = this.taskColor;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
