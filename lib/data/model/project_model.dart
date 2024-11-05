import 'package:sectar_web/data/model/milestone_model.dart';

import 'User.dart';

class Project {
  int? id;
  int? userId;
  int? clientId;
  String? projectName;
  int? estimatedBudget;
  String? startDate;
  String? projectStatus;
  String? projectNotes;
  String? projectRejectedNotes;
  String? projectChanges;
  String? clientName;
  String? clientEmail;
  String? clientNotes;
  int? autoPayDays;
  String? transferGroup;
  String? paymentIntentId;
  String? projectColor;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Milestone>? milestone;
  User? user;

  Project(
      {this.id,
      this.userId,
      this.clientId,
      this.projectName,
      this.estimatedBudget,
      this.startDate,
      this.projectStatus,
      this.projectNotes,
      this.clientName,
      this.projectColor,
      this.clientEmail,
      this.clientNotes,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.milestone,
      this.user,
      this.autoPayDays,
      this.paymentIntentId,
      this.projectChanges,
      this.projectRejectedNotes,
      this.transferGroup});

  Project.fromJson(Map<String, dynamic> json) {
    autoPayDays = json['auto_pay_days'];
    paymentIntentId = json['payment_intent_id'];
    projectChanges = json['project_changes'];
    projectRejectedNotes = json['project_rejected_notes'];
    transferGroup = json['transfer_group'];
    userId = json['userId'];
    clientId = json['clientId'];
    id = json['id'];
    projectName = json['project_name'];
    estimatedBudget = json['estimated_budget'];
    startDate = json['start_date'];
    projectColor = json['project_color'];
    projectStatus = json['project_status'];
    projectNotes = json['project_notes'];
    clientName = json['client_name'];
    clientEmail = json['client_email'];
    clientNotes = json['client_notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['milestone'] != null) {
      milestone = <Milestone>[];
      json['milestone'].forEach((v) {
        milestone!.add(Milestone.fromJson(v));
      });
    }

    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auto_pay_days'] = autoPayDays;
    data['payment_intent_id'] = paymentIntentId;
    data['project_changes'] = projectChanges;
    data['project_rejected_notes'] = projectRejectedNotes;
    data['transfer_group'] = transferGroup;

    data['id'] = id;
    data['userId'] = userId;
    data['clientId'] = clientId;
    data['project_color'] = projectColor;
    data['project_name'] = projectName;
    data['estimated_budget'] = estimatedBudget;
    data['start_date'] = startDate;
    data['project_status'] = projectStatus;
    data['project_notes'] = projectNotes;
    data['client_name'] = clientName;
    data['client_email'] = clientEmail;
    data['client_notes'] = clientNotes;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (milestone != null) {
      data['milestone'] = milestone!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
