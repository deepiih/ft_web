import 'package:dio/dio.dart';
import 'package:sectar_web/package/config_packages.dart';

late Dio dio;

String proxy = "";

BaseOptions baseOptions = BaseOptions(connectTimeout: const Duration(seconds: 30), receiveTimeout: const Duration(seconds: 30));

String baseUrl =  '';

Future<void> dioSetUp({int? language}) async {
  dio = Dio(baseOptions);

  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions option, RequestInterceptorHandler handler) async {
    var customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      if (AppPref().token.isNotEmpty) 'Authorization': 'Bearer ${AppPref().token}',
    };
    option.headers.addAll(customHeaders);
    handler.next(option);
  }));
  if (!kReleaseMode) {
    var logger = PrettyDioLogger(
      maxWidth: 232,
      requestHeader: true,
      requestBody: true,
    );
    dio.interceptors.add(logger);
  }

  dio.options.baseUrl = baseUrl;
}
