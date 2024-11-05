import 'package:sectar_web/package/config_packages.dart';

abstract class AppColor {
  static changeThemeMode() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      AppPref().isDark = false;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      AppPref().isDark = true;
    }
  }

  const AppColor._();

  static bool isDarkTheme() {
    return Get.isDarkMode;
  }

  static const primaryColor = Color(0xFF2949F4);
  static const lightBlackColor = Color(0xFF333333);
  static const lightGreyColor = Color(0xFF808080);
  static const textSecondaryColor = Color(0xFF7E8195);
  static const successStatusColor = Color(0xFF34A853);
  static const errorStatusColor = Color(0xFFF04848);
  static const white = Color(0xFFFFFFFF);
  static const backgroundStokeColor = Color(0xFFE5E5E5);
  static const black = Color(0xFF000000);
  static const navigationRailColor = Color(0xFFF8F8F8);
  static const lightPrimaryColor = Color(0xFFDBDFF2);
  static const orangeColor = Color(0xFFFF965A);
  static const purpleColor = Color(0xFF834CF6);
  static const cylinderColor = Color(0xFF60ADB1);
}

class LightTheme {
  static const primary = Color(0xff18191A);
}

class DarkTheme {
  static const primary = Color(0xff18191A);
}
