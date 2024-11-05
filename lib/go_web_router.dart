import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class GoRouterNamed {
  static const initial = '/';
  static const login = 'login';
  static const otp = 'otp';
  static const name = 'name';
  static const dashboard = 'dashboard';
  static const profile = 'profile';
  static const project = 'project';
  static const step1 = 'step1';
  static const step2 = 'step2';
  static const step3 = 'step3';
  static const step4 = 'step4';
  static const reviewProject = 'reviewProject';
  static const view = 'view';
  static const clientReviewProject = 'clientReviewProject';
  static const projectDashboard = 'projectDashboard';
  static const task = 'task';
  static const transaction = 'transaction';
  static const notFound = '404';
  static const success = 'success';
}

class GoRouterPath {
  static const initial = '/';
  static const login = '/login';
  static const otp = '/otp';
  static const name = '/name';
  static const dashboard = '/dashboard';
  static const profile = 'profile';
  static const project = '/project';
  static const step1 = 'step1';
  static const step2 = 'step2/:isFromAddMileStone';
  static const step3 = 'step3';
  static const step4 = 'step4';
  static const reviewProject = 'reviewProject';
  static const view = 'view';
  static const clientReviewProject = '/clientReviewProject';
  static const projectDashboard = 'projectDashboard';
  static const task = 'task';
  static const transaction = '/transaction';
  static const notFound = '/404';
  static const success = '/success';
}

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}

final GoRouter router = GoRouter(
  onException: (_, GoRouterState state, GoRouter router) {
    router.goNamed(GoRouterNamed.notFound, extra: state.uri.toString());
  },
  redirect: (BuildContext context, GoRouterState state) {
    final bool isAuthenticated = AppPref().token.isNotEmpty;
    final bool isAuthScreen = state.matchedLocation == '/login' || state.matchedLocation == '/otp';
    final bool clientReviewProject = state.matchedLocation == '/clientReviewProject';
    if (clientReviewProject) {
      return state.uri.toString();
    } else if (!isAuthenticated && !(isAuthScreen)) {
      return '/login?user=freelancer';
    } else if (isAuthenticated && isAuthScreen) {
      return '/';
    }
    return null;
  },
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: GoRouterNamed.clientReviewProject,
      path: GoRouterPath.clientReviewProject,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return FadeTransitionPage(
          key: state.pageKey,
          child: ClientProjectReviewScreen(
            projectId: state.uri.queryParameters['projectId'] ?? "",
            milestoneId: state.uri.queryParameters['milestoneId'] ?? "",
          ),
        );
      },
    ),
    GoRoute(
      name: GoRouterNamed.notFound,
      path: GoRouterPath.notFound,
      builder: (BuildContext context, GoRouterState state) {
        return NotFoundScreen(uri: state.extra as String? ?? '');
      },
    ),
    GoRoute(
      name: GoRouterNamed.success,
      path: GoRouterPath.success,
      builder: (BuildContext context, GoRouterState state) {
        return const ProjectLiveScreen();
      },
    ),
    GoRoute(
      name: GoRouterNamed.initial,
      path: GoRouterPath.initial,
      redirect: (_, __) {
        if (AppPref().userType == 1) {
          return GoRouterPath.dashboard;
        } else {
          return GoRouterPath.project;
        }
      },
    ),
    GoRoute(
      name: GoRouterNamed.name,
      path: GoRouterPath.name,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return FadeTransitionPage(
          key: state.pageKey,
          child: const NameScreen(),
        );
      },
    ),
    GoRoute(
      name: GoRouterNamed.otp,
      path: GoRouterPath.otp,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return FadeTransitionPage(
          key: state.pageKey,
          child: OtpScreen(
            email: state.uri.queryParameters['email'] ?? "",
            userType: state.uri.queryParameters['user'] ?? "",
          ),
        );
      },
    ),
    GoRoute(
      name: GoRouterNamed.login,
      path: GoRouterPath.login,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return FadeTransitionPage(
          key: state.pageKey,
          child: LoginScreen(
            userType: state.uri.queryParameters['user'] ?? "",
          ),
        );
      },
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return WebScaffold(
          selectedTab: AppPref().userType == 1 ? ScaffoldTab.dashboard : ScaffoldTab.project,
          child: child,
        );
      },
      routes: <RouteBase>[
        GoRoute(
          name: GoRouterNamed.dashboard,
          path: GoRouterPath.dashboard,
          pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
            key: state.pageKey,
            child: const DashBoardScreen(),
          ),
          routes: <RouteBase>[
            GoRoute(
              name: GoRouterNamed.profile,
              path: GoRouterPath.profile,
              pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
                key: state.pageKey,
                child: ProfileScreen(),
              ),
              routes: const <RouteBase>[],
            ),
          ],
        ),
        GoRoute(
          name: GoRouterNamed.project,
          path: GoRouterPath.project,
          pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
            key: state.pageKey,
            child: const ProjectScreen(),
          ),
          routes: <RouteBase>[
            GoRoute(
              name: GoRouterNamed.projectDashboard,
              path: GoRouterPath.projectDashboard,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: ProjectDashScreen(
                    projectId: state.uri.queryParameters['projectId'] ?? "",
                  ),
                );
              },
            ),
            GoRoute(
              name: GoRouterNamed.step1,
              path: GoRouterPath.step1,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: StepOneScreen(
                    projectId: state.uri.queryParameters['projectId'] ?? "",
                  ),
                );
              },
            ),
            GoRoute(
                name: GoRouterNamed.step2,
                path: GoRouterPath.step2,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return FadeTransitionPage(
                    key: state.pageKey,
                    child: StepTwoScreen(
                      isFirstMilestone: state.pathParameters['isFromAddMileStone']!,
                      projectId: state.uri.queryParameters['projectId'] ?? "",
                      milestoneId: state.uri.queryParameters['milestoneId'] ?? "",
                    ),
                  );
                }),
            GoRoute(
              name: GoRouterNamed.step3,
              path: GoRouterPath.step3,
              pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
                key: state.pageKey,
                child: StepThreeScreen(
                  projectId: state.uri.queryParameters['projectId'] ?? "",
                ),
              ),
            ),
            GoRoute(
              name: GoRouterNamed.step4,
              path: GoRouterPath.step4,
              pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
                key: state.pageKey,
                child: StepFourScreen(
                  projectId: state.uri.queryParameters['projectId'] ?? "",
                ),
              ),
            ),
            GoRoute(
              name: GoRouterNamed.reviewProject,
              path: GoRouterPath.reviewProject,
              pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
                key: state.pageKey,
                child: ReviewProjectScreen(
                  projectId: state.uri.queryParameters['projectId'] ?? "",
                ),
              ),
            ),
            GoRoute(
              name: GoRouterNamed.view,
              path: GoRouterPath.view,
              pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
                key: state.pageKey,
                child: ViewProjectScreen(
                  projectId: state.uri.queryParameters['projectId'] ?? "",
                  milestoneId: state.uri.queryParameters['milestoneId'] ?? "",
                ),
              ),
            ),
            GoRoute(
              name: GoRouterNamed.task,
              path: GoRouterPath.task,
              pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
                key: state.pageKey,
                child: TaskScreen(
                  milestoneId: state.uri.queryParameters['milestoneId'] ?? "",
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          name: GoRouterNamed.transaction,
          path: GoRouterPath.transaction,
          pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
            key: state.pageKey,
            child: const TransactionScreen(),
          ),
          routes: const <RouteBase>[],
        ),
      ],
    ),
  ],
);
