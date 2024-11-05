import 'package:sectar_web/package/config_packages.dart';

class Responsive {
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 850;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;
}
