import 'package:sectar_web/package/config_packages.dart';

class WebApp extends StatefulWidget {
  const WebApp({super.key});

  @override
  State<WebApp> createState() => _WebAppState();
}

class _WebAppState extends State<WebApp> with WidgetsBindingObserver {
  var locales = [
    const Locale('en', ''),
  ];

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      key: Get.key,
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      title: 'Web App',
      locale: const Locale('en', ''),
      supportedLocales: locales,
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: (MediaQuery.of(context).platformBrightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark),
          child: child ?? Container(),
        );
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
