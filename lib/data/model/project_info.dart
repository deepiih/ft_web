import 'package:sectar_web/data/model/project_model.dart';

class ProjectInfo {
  bool? status;
  List<Project>? project;
  String? userName;
  String? userEmail;

  ProjectInfo({this.status, this.project,this.userName,this.userEmail});

  ProjectInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    if (json['project'] != null) {
      project = <Project>[];
      json['project'].forEach((v) {
        project!.add(Project.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    if (project != null) {
      data['project'] = project!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
