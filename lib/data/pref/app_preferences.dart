import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  Future? _isPreferenceInstanceReady;
  late SharedPreferences _preferences;

  static final AppPref _instance = AppPref._internal();

  factory AppPref() => _instance;

  AppPref._internal() {
    _isPreferenceInstanceReady = SharedPreferences.getInstance().then((preferences) => _preferences = preferences);
  }

  Future? get isPreferenceReady => _isPreferenceInstanceReady;

  String get token => _preferences.getString('token') ?? '';

  set token(String value) => _preferences.setString('token', value);

  String get name => _preferences.getString('name') ?? '';

  set name(String value) => _preferences.setString('name', value);

  String get email => _preferences.getString('email') ?? '';

  set email(String value) => _preferences.setString('email', value);

  String get languageCode => _preferences.getString('languageCode') ?? '';

  set languageCode(String value) => _preferences.setString('languageCode', value);

  String get verificationId => _preferences.getString('verificationId') ?? '';

  set verificationId(String value) => _preferences.setString('verificationId', value);

  bool? get isLogin => _preferences.getBool('isLogin');

  set isLogin(bool? value) => _preferences.setBool('isLogin', value ?? false);

  int get userType => _preferences.getInt('userType') ?? 0;

  set userType(int value) => _preferences.setInt(
        'userType',
        value,
      );

  bool? get isAdmin => _preferences.getBool('isAdmin');

  set isAdmin(bool? value) => _preferences.setBool('isAdmin', value ?? false);

  bool? get isDark => _preferences.getBool('isDark');

  set isDark(bool? value) => _preferences.setBool('isDark', value ?? false);

  void clear() async {
    _preferences.remove("isBiometricEnable");
    _preferences.remove("isLogin");
    _preferences.remove("token");
    _preferences.remove("fcmToken");
    _preferences.remove("isGuest");
    _preferences.remove("loginUser");
  }
}
