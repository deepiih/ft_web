import 'package:sectar_web/package/config_packages.dart';

class DashBoardController extends GetxController {
  RxList<OverView> overViewList = <OverView>[].obs;

  RxBool isLoading = false.obs;
  RxBool getDashboardLoading = false.obs;
  Rxn<GetDashboard> getDashboardModel = Rxn<GetDashboard>();

  Future<void> getDashboard() async {
    overViewList.add(OverView(
      price: "1000",
      title: CommonString.lifeTimeRevenue.toUpperCase(),
    ));
    overViewList.add(OverView(
      price: "1023",
      title: CommonString.underReviewFunds.toUpperCase(),
    ));
    overViewList.add(OverView(
      price: "200",
      title: CommonString.lastWeekRevenue.toUpperCase(),
    ));
  }

  @override
  void onInit() {
    getDashboard();

    super.onInit();
  }
}
