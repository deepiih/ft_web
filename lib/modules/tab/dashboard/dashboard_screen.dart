import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final dashBoardController = Get.put(DashBoardController());

  @override
  void dispose() {
    Get.delete<DashBoardController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return dashBoardController.getDashboardLoading.value
          ? Center(child: showLoadingDialog())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    CommonString.overview,
                    style: const TextStyle().normal18w400.textColor(AppColor.textSecondaryColor),
                  ),
                  const Gap(23),
                  OverViewWidget(
                    overViewList: dashBoardController.overViewList,
                  ),
                  const Gap(23),
                  if (dashBoardController.getDashboardModel.value?.isStripeOnboardingCompleted == true)
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            height: 20,
                            AppImage.nextButton,
                          ),
                          const Gap(8),
                          Text(
                            CommonString.viewDashboardOnStripe,
                            style: const TextStyle().normal16w400.textColor(AppColor.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  const Gap(50),
                  Text(
                    CommonString.getStartedHere,
                    style: const TextStyle().normal18w400.textColor(AppColor.textSecondaryColor),
                  ),
                  const Gap(24),
                  _newProjectBankAccountWidget(),
                  const Gap(56),
                  Visibility(
                    visible: dashBoardController.getDashboardModel.value?.videos?.isNotEmpty ?? false,
                    child: Text(
                      CommonString.linksHelpsToYou,
                      style: const TextStyle().normal18w400.textColor(AppColor.textSecondaryColor),
                    ),
                  ),
                  const Gap(40),
                  _buildVideoList(),
                ],
              ),
            );
    });
  }

  Wrap _newProjectBankAccountWidget() {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        _dottedContainer(
          onButtonTap: () {
            context.pushNamed(GoRouterNamed.step1);
          },
          buttonType: ButtonType.enable,
          icon: AppImage.createProject,
          title: CommonString.createNewProject,
          subTitle: CommonString.createNewProjectDesc,
          iconColor: AppColor.primaryColor,
        ),
        Obx(() {
          return dashBoardController.getDashboardModel.value?.isStripeOnboardingCompleted == true
              ? const SizedBox()
              : _dottedContainer(
                  onButtonTap: () async {},
                  buttonType: dashBoardController.isLoading.value ? ButtonType.progress : ButtonType.enable,
                  icon: AppImage.dollar,
                  title: CommonString.connectBankAccount,
                  subTitle: CommonString.connectBankAccountDesc,
                  iconColor: AppColor.successStatusColor,
                );
        }),
      ],
    );
  }

  DottedBorder _dottedContainer({
    required String icon,
    title,
    subTitle,
    Color? iconColor,
    required Function()? onButtonTap,
    required ButtonType buttonType,
  }) {
    return DottedBorder(
      color: AppColor.primaryColor,
      dashPattern: const [6, 6, 6, 6],
      borderType: BorderType.Rect,
      radius: const Radius.circular(20),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              height: 28,
              icon,
              color: iconColor,
            ),
            const Gap(25),
            Text(
              title,
              style: const TextStyle().normal20w400.textColor(AppColor.lightBlackColor),
            ),
            const Gap(8),
            Text(
              subTitle,
              style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
            ),
            const Gap(16),
            CommonAppButton(
              isAddButton: true,
              buttonColor: iconColor,
              onTap: onButtonTap,
              buttonType: buttonType,
              text: title,
              width: 210,
            )
          ],
        ),
      ),
    );
  }

  ListView _buildVideoList() {
    return ListView.separated(
      physics: const ScrollPhysics(),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 20,
        );
      },
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              height: 28,
              AppImage.play,
              color: AppColor.primaryColor,
            ),
            const Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Zenith Project Manager",
                    style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                  ),
                  Text(
                    "Empowering Teams to Achieve Milestones Swiftly",
                    style: const TextStyle().normal18w400.textColor(AppColor.textSecondaryColor),
                  ),
                ],
              ),
            ),
            const Gap(10),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  launchUrl(
                    Uri.parse(
                      "https://www.youtube.com/",
                    ),
                  );
                },
                child: Row(
                  children: [
                    Image.asset(
                      height: 20,
                      AppImage.nextButton,
                    ),
                    const Gap(8),
                    Text(
                      CommonString.watchVideo,
                      style: const TextStyle().normal18w400.textColor(AppColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
