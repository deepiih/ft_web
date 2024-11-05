import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dioSetUp();
  FlutterSmartDialog.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  setPathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await AppPref().isPreferenceReady;
  AppPref().languageCode = 'en';
  runApp(
    const WebApp(),
  );
}
