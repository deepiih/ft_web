class Milestone {
  int? id;
  int? projectId;
  int? isFirstMilestone;
  String? milestoneName;
  int? milestoneBudget;
  String? startDate;
  String? endDate;
  String? milestoneStatus;
  String? description;
  String? deliverables;
  String? attachments;
  String? transferGroup;
  String? paymentIntentId;
  String? milestoneColor;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? rejectNotes;
  String? changeNotes;

  Milestone(
      {this.id,
      this.projectId,
      this.isFirstMilestone,
      this.milestoneName,
      this.milestoneBudget,
      this.startDate,
      this.endDate,
      this.description,
      this.deliverables,
      this.attachments,
      this.createdAt,
      this.updatedAt,
      this.milestoneStatus,
      this.milestoneColor,
      this.deletedAt,
      this.paymentIntentId,
      this.changeNotes,
      this.rejectNotes,
      this.transferGroup});

  Milestone.fromJson(Map<String, dynamic> json) {
    paymentIntentId = json['payment_intent_id'];
    changeNotes = json['change_notes'];
    rejectNotes = json['reject_notes'];
    transferGroup = json['transfer_group'];

    id = json['id'];
    projectId = json['project_id'];
    isFirstMilestone = json['is_first_milestone'];
    milestoneName = json['milestone_name'];
    milestoneBudget = json['milestone_budget'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    deliverables = json['deliverables'];
    attachments = json['attachments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    milestoneStatus = json['milestone_status'];
    milestoneColor = json['milestone_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_intent_id'] = paymentIntentId;
    data['change_notes'] = changeNotes;
    data['reject_notes'] = rejectNotes;
    data['transfer_group'] = transferGroup;
    data['end_date'] = endDate;
    data['id'] = id;
    data['project_id'] = projectId;
    data['is_first_milestone'] = isFirstMilestone;
    data['milestone_name'] = milestoneName;
    data['milestone_budget'] = milestoneBudget;
    data['start_date'] = startDate;
    data['description'] = description;
    data['deliverables'] = deliverables;
    data['attachments'] = attachments;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['milestone_status'] = milestoneStatus;
    data['milestone_color'] = milestoneColor;
    return data;
  }
}
