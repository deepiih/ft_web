import 'package:sectar_web/data/model/User.dart';
import 'package:sectar_web/data/model/milestone_model.dart';
import 'package:sectar_web/data/model/project_info.dart';
import 'package:sectar_web/data/model/project_model.dart';
import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

class ProjectDashController extends GetxController {
  RxList<OverView> overView = <OverView>[
    OverView(price: "120", title: CommonString.projectValue.toUpperCase()),
    OverView(price: "210", title: CommonString.avgPayoutTime.toUpperCase()),
    OverView(price: "540", title: CommonString.avgPayoutTime.toUpperCase()),
    OverView(price: "3430", title: CommonString.avgPayoutTime.toUpperCase()),
    OverView(price: "540", title: CommonString.avgPayoutTime.toUpperCase()),
  ].obs;

  RxBool isGetProjectLoading = false.obs;

  Rxn<ProjectInfo> projectInfo = Rxn<ProjectInfo>();

  Future<void> getProjectInfo({
    required String projectId,
  }) async {
    // try {
    //   isGetProjectLoading.value = true;
    // Create a dummy User instance
    for (int i = 1; i <= 1; i++) {
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
          milestoneStatus: i % 2 != 0 ? "Live" : 'Draft',
          milestoneColor: i % 2 != 0 ? '#34A853' : '#7E8195',
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
        projectStatus: i % 2 != 0 ? "Live" : 'Draft',
        projectNotes: 'Notes for project $i',
        projectRejectedNotes: 'Rejected notes for project $i',
        projectChanges: 'Changes for project $i',
        clientName: 'Client $i',
        clientEmail: 'client$i@example.com',
        clientNotes: 'Notes from client $i',
        projectColor: i % 2 != 0 ? '#34A853' : '#7E8195',
        createdAt: '2024-11-01',
        updatedAt: '2024-11-02',
        milestone: milestones,
        user: user,
      );
      projectInfo.value = ProjectInfo(
          status: true,
          project: [project],
        userEmail: "demo@gmail.com",
        userName: "Demo"
      );
    }

    // isGetProjectLoading.value = false;
    // } catch (e) {
    //   isGetProjectLoading.value = false;
    //
    //   debugPrint(e.toString());
    // }
  }
}
