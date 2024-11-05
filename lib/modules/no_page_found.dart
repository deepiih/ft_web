import 'package:sectar_web/package/config_packages.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, required this.uri});

  final String uri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "404.",
                  style: const TextStyle().normal32w600.textColor(AppColor.lightBlackColor),
                ),
                Text(
                  " That's an error",
                  style: const TextStyle().normal24w400.textColor(AppColor.textSecondaryColor),
                ),
              ],
            ),
            const Gap(30),

            Center(
              child: Text(
                "The request URL $uri was not found on this server",
                textAlign: TextAlign.center,
                style: const TextStyle().normal18w400.textColor(AppColor.textSecondaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
