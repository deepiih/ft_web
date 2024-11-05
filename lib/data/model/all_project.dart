import 'package:sectar_web/data/model/project_model.dart';

class GetAllProjectModel {
  bool? status;
  List<Project>? projects;

  GetAllProjectModel({
    this.status,
    this.projects,
  });

  GetAllProjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['projects'] != null) {
      projects = <Project>[];
      json['projects'].forEach((v) {
        projects!.add(Project.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (projects != null) {
      data['projects'] = projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

