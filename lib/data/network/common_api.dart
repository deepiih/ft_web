import 'package:sectar_web/package/config_packages.dart';

class CommonApi {
  static Future<ProjectInfo?> getProjectInfo({
    required String projectId,
  }) async {
    try {
      var resp = await callApi(
        dio.get(
          '${EndPoint.get_project_info}/$projectId',
        ),
      );
      if (resp?.data[CommonString.status] == true) {
        return ProjectInfo.fromJson(resp?.data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
