import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

class WebScaffold extends StatelessWidget {
  WebScaffold({
    required this.selectedTab,
    required this.child,
    super.key,
  }) {
    controller = Get.put(DashBoardController());
  }

  late final DashBoardController controller;
  final ScaffoldTab selectedTab;
  final Widget child;

  static int _calculateSelectedIndex(BuildContext context, {int? userType}) {
    final String location = GoRouterState.of(context).uri.toString();
    switch (userType) {
      case 1:
        if (location.startsWith(GoRouterPath.dashboard)) return 0;
        if (location.startsWith(GoRouterPath.project)) return 1;
        if (location.startsWith(GoRouterPath.transaction)) return 2;
        break;
      case 2:
        if (location.startsWith(GoRouterPath.project)) return 0;
        if (location.startsWith(GoRouterPath.transaction)) return 1;
        break;
    }
    return 0;
  }

  void _onItemTapped({required int userType, required int index, required BuildContext context}) {
    Navigator.pop(context);
    if (userType == 1) {
      switch (index) {
        case 0:
          GoRouter.of(context).replace(GoRouterPath.dashboard);
          break;
        case 1:
          GoRouter.of(context).replace(GoRouterPath.project);
          break;
        case 2:
          GoRouter.of(context).replace(GoRouterPath.transaction);
          break;
      }
    } else {
      switch (index) {
        case 0:
          GoRouter.of(context).replace(GoRouterPath.project);
          break;
        case 1:
          GoRouter.of(context).replace(GoRouterPath.transaction);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) => SelectionArea(
        child: AdaptiveNavigationScaffold(
          isClient: AppPref().userType == 2,
          appBar: _appBarWidget(context),
          onNewProjectTap: () {
            Navigator.pop(context);
            context.pushNamed(GoRouterNamed.step1);
          },
          backgroundColor: AppColor.white,
          selectedIndex: _calculateSelectedIndex(context, userType: AppPref().userType),
          body: child,
          onDestinationSelected: (int idx) => _onItemTapped(index: idx, context: context, userType: AppPref().userType),
          includeBaseDestinationsInMenu: false,
          destinations: <AdaptiveScaffoldDestination>[
            if (AppPref().userType != 2) ...[
              const AdaptiveScaffoldDestination(
                title: CommonString.dashboard,
                icon: AppImage.dashboard,
              ),
            ],
            const AdaptiveScaffoldDestination(
              title: CommonString.projects,
              icon: AppImage.project,
            ),
            const AdaptiveScaffoldDestination(
              title: CommonString.transactions,
              icon: AppImage.transaction,
            ),
          ],
        ),
      );

  AppBar _appBarWidget(context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: AppColor.backgroundStokeColor,
          height: 2.0,
        ),
      ),
      forceMaterialTransparency: true,
      elevation: 0,
      leadingWidth: 80,
      leading: Responsive.isMobile(context)
          ? null
          : const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Icon(
                color: AppColor.lightBlackColor,
                size: 30,
                Icons.energy_savings_leaf_sharp,
              ),
            ),
      actions: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context).pushNamed(GoRouterNamed.profile);
          },
          child: Image.asset(
            AppImage.setting,
            height: 20,
            width: 20,
          ),
        ),
        const Gap(24),
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            AppImage.info,
            height: 20,
            width: 20,
          ),
        ),
        const Gap(24),
        _profileMenuWidget(context),
        const Gap(24),
      ],
    );
  }

  Theme _profileMenuWidget(context) {
    return Theme(
      data: ThemeData(
        useMaterial3: false,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: PopupMenuButton<String>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        offset: const Offset(-10, 10),
        shadowColor: Colors.white,
        color: AppColor.white,
        onSelected: (val) async {
          if (val == CommonString.logtOut) {
            showDialog(
                context: context,
                builder: (context) {
                  return AddNoteDialog(
                    icon: AppImage.information,
                    buttonText: CommonString.sure,
                    title: CommonString.wantToLogOut,
                    buttonType: ButtonType.enable,
                    onCancelTap: () {
                      Navigator.pop(context);
                    },
                    textEditingController: TextEditingController(),
                    onSendTap: (val) async {
                      Navigator.pop(context);
                      AppPref().clear();
                      context.pushReplacementNamed(GoRouterNamed.login);
                    },
                  );
                });
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            enabled: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppPref().name,
                  style: const TextStyle().normal16w700.textColor(AppColor.lightBlackColor),
                ),
                const Gap(6),
                Text(
                  AppPref().email,
                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                ),
                const Gap(10),
              ],
            ),
          ),
          if (AppPref().userType == 1 && controller.getDashboardModel.value?.isStripeOnboardingCompleted == true)
            PopupMenuItem<String>(
              height: 10,
              enabled: false,
              padding: EdgeInsets.zero,
              child: Divider(
                thickness: 1,
                color: AppColor.lightBlackColor.withOpacity(0.10),
              ),
            ),
          if (AppPref().userType == 1 && controller.getDashboardModel.value?.isStripeOnboardingCompleted == true)
            PopupMenuItem<String>(
              child: Row(
                children: [
                  Image.asset(
                    AppImage.bank,
                    color: AppColor.primaryColor,
                    height: 15,
                  ),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      CommonString.bankAccountConnected,
                      style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                    ),
                  ),
                  Image.asset(
                    AppImage.right,
                    color: AppColor.successStatusColor,
                    height: 15,
                  ),
                ],
              ),
            ),
          if (AppPref().userType == 1 && controller.getDashboardModel.value?.isStripeOnboardingCompleted == true)
            PopupMenuItem<String>(
              child: Row(
                children: [
                  Image.asset(
                    AppImage.warning,
                    height: 18,
                  ),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      controller.getDashboardModel.value?.instantPayoutSupported == true ? CommonString.instantPayoutEnabled : CommonString.dailyPayoutEnabled,
                      style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                    ),
                  ),
                  Image.asset(
                    AppImage.right,
                    color: AppColor.successStatusColor,
                    height: 15,
                  ),
                ],
              ),
            ),
          if (AppPref().userType == 1 && controller.getDashboardModel.value?.isStripeOnboardingCompleted == true)
            PopupMenuItem<String>(
              height: 10,
              enabled: false,
              padding: EdgeInsets.zero,
              child: Divider(
                thickness: 1,
                color: AppColor.lightBlackColor.withOpacity(0.10),
              ),
            ),
          if (AppPref().userType == 1 && controller.getDashboardModel.value?.isStripeOnboardingCompleted == true)
            PopupMenuItem<String>(
              child: Text(
                CommonString.viewYourPayoutDashboard,
                style: const TextStyle().normal16w400.textColor(AppColor.primaryColor),
              ),
            ),
          PopupMenuItem<String>(
            value: CommonString.logtOut,
            child: Text(
              CommonString.logtOut,
              style: const TextStyle().normal16w400.textColor(AppColor.errorStatusColor),
            ),
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          width: 30,
          height: 30,
          child: Center(
            child: Text(
              getInitials(
                AppPref().name.toUpperCase(),
              ),
              style: const TextStyle().normal14w700.textColor(AppColor.white),
            ),
          ),
        ),
      ),
    );
  }
}
