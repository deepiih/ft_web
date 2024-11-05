import 'package:sectar_web/data/model/User.dart';
import 'package:sectar_web/data/model/all_project.dart';
import 'package:sectar_web/data/model/milestone_model.dart';
import 'package:sectar_web/data/model/project_model.dart';
import 'package:sectar_web/package/config_packages.dart';

class ProjectController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isDeleteLoading = false.obs;
  Rxn<GetAllProjectModel> getAllProjectModel = Rxn<GetAllProjectModel>();

  Future<void> getAllProjectAApi() async {
    List<Project> dummyProjects = [];
    for (int i = 1; i <= 10; i++) {
      // Create a dummy User instance
      User user = User(
        id: i,
        email: 'user$i@example.com',
        name: 'User $i',
      );

      // Create a list of dummy Milestones for each project
      List<Milestone> milestones = List.generate(3, (index) {
        return Milestone(
          id: index + 1,
          projectId: i,
          isFirstMilestone: index == 0 ? 1 : 0,
          milestoneName: 'Milestone ${index + 1}',
          milestoneBudget: (index + 1) * 1000,
          startDate: '2024-11-0${index + 1}',
          endDate: '2024-11-1${index + 1}',
          description: 'Description for milestone ${index + 1}',
          deliverables: 'Deliverables for milestone ${index + 1}',
          attachments: 'attachment${index + 1}.pdf',
          milestoneStatus: i%2==0?"Live":'Draft',
          milestoneColor: i%2==0?'#34A853': '#7E8195',
        );
      });

      // Create a dummy Project instance
      Project project = Project(
        id: i,
        userId: i,
        clientId: i,
        projectName: 'Project $i',
        estimatedBudget: 10000 + i * 1000,
        startDate: '2024-11-01',
        projectStatus:i%2==0?"Live":'Draft',
        projectNotes: 'Notes for project $i',
        projectRejectedNotes: 'Rejected notes for project $i',
        projectChanges: 'Changes for project $i',
        clientName: 'Client $i',
        clientEmail: 'client$i@example.com',
        clientNotes: 'Notes from client $i',
        projectColor:  i%2==0?'#34A853': '#7E8195',
        createdAt: '2024-11-01',
        updatedAt: '2024-11-02',
        milestone: milestones,
        user: user,
      );

      dummyProjects.add(project);
    }

    getAllProjectModel.value = GetAllProjectModel(
      status: true,
      projects: dummyProjects,
    );
  }

  Future<void> deleteProjectApi({required BuildContext context, required String projectId}) async {
    try {
      isDeleteLoading.value = true;
      var resp = await callApi(
        dio.delete(
          '${EndPoint.delete_project}/$projectId',
        ),
      );

      if (resp?.data[CommonString.status] == true) {
        if (context.mounted) {
          getAllProjectModel.value?.projects?.removeWhere((element) => element.id.toString() == projectId);
          getAllProjectModel.refresh();
          Navigator.of(context).pop();
        }
      }
      isDeleteLoading.value = false;
    } catch (e) {
      isDeleteLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
