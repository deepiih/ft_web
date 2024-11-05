import 'package:sectar_web/package/config_packages.dart';

class StepOneController extends GetxController {
  Rx<TextEditingController> projectNameController = TextEditingController().obs;
  Rx<TextEditingController> projectBudgetController = TextEditingController().obs;
  Rx<TextEditingController> startDateController = TextEditingController().obs;
  DateTime selectedDate = DateTime.now();
  RxBool isLoading = false.obs;
  RxBool isGetProjectLoading = false.obs;

  Rxn<ProjectInfo> projectInfo = Rxn<ProjectInfo>();

  Future<void> createProject({
    required BuildContext context,
    required String projectName,
    required projectBudget,
    required startDate,
    final String? projectId,
  }) async {
    GoRouter.of(context).pushNamed(
      GoRouterNamed.step2,
      queryParameters: {
        'projectId': "1",
      },
      pathParameters: <String, String>{'isFromAddMileStone': '1'},
    );
  }
}
