import 'package:sectar_web/package/config_packages.dart';
import 'package:dio/dio.dart';

bool isInternetAvailable = true;

Future<T?> callApi<T>(Future<T> request, [bool doShowLoader = false]) async {
  if (!isInternetAvailable) {
    showErrorToast('Internet not available');
    return null;
  }
  try {
    if (doShowLoader) showLoader(isCancelable: false);
    var response = await request;
    if (doShowLoader) dismissLoader();
    return response;
  } on DioError catch (dioError) {
    if (doShowLoader) dismissLoader();
    onResponseError(dioError);
  } catch (error) {
    if (doShowLoader) dismissLoader();
    debugPrint("callApi :: Error -> $error");
  }
  return null;
}

onResponseError(onError) {
  if (onError is DioError) {
    switch (onError.response?.statusCode) {
      case 400:
      case 401:
        if (AppPref().token.isNotEmpty) {
          var languageCode = AppPref().languageCode;
          var isDark = AppPref().isDark;
          Get.deleteAll();

          AppPref().isDark = isDark;
          AppPref().languageCode = languageCode;

          AppPref().clear();
        } else {
          showAppToast('UNAUTHORIZED');
        }

        break;
      case 403:
      case 404:
        break;
      case 406:
        var json = onError.response?.data;
        if (kDebugMode) {
          print(json.toString().replaceAll('[', '').replaceAll(']', ''));
        }
        throw onError;
      case 408:
      case 409:
      case 422:
      case 423:
      case 426:
        break;
      case 500:
        showAppToast(
          'Internal Server Error',
        );
        break;
      default:
        break;
    }
  }
}

