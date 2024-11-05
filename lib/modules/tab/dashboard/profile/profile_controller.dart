
import 'package:sectar_web/package/config_packages.dart';


class ProfileController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  RxBool isLoading = false.obs;

}
