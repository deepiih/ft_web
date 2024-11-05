import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final nameController = Get.put<NameController>(NameController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<NameController>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Center(
          child: SizedBox(
            width: Responsive.isDesktop(context) ? 400 : double.infinity,
            child: SingleChildScrollView(
              padding: Responsive.isMobile(context)
                  ? const EdgeInsets.all(20.0)
                  : EdgeInsets.zero,
              child: _buildNameWidget(context),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildNameWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(
                color: AppColor.lightBlackColor,
                Icons.energy_savings_leaf_sharp,
              ),
            ),
            Text(
              "STRIVEBOARD",
              style: const TextStyle().normal24w700.textColor(AppColor.lightBlackColor),

            ),
          ],
        ),

        const Gap(40),
        Text(
          CommonString.whatIsYourName,
          style: const TextStyle()
              .normal24w700
              .textColor(AppColor.lightBlackColor),
        ),
        const Gap(16),
        Text(
          CommonString.sendEmailToYourVendors,
          style:
              const TextStyle().normal18w400.textColor(AppColor.lightGreyColor),
        ),
        const Gap(32),
        Text(
          CommonString.enterName,
          style:
              const TextStyle().normal16w400.textColor(AppColor.lightGreyColor),
        ),
        const Gap(12),
        Form(
          key: _formKey,
          child: InputField(
            onSubmitted: (val) async {
              if (_formKey.currentState!.validate()) {
                await nameController.updateProfile(
                  context: context,
                  name: nameController.nameFieldController.value.text.trim(),
                );
              }
            },
            keyboardType: TextInputType.name,
            hint: CommonString.enterName,
            fillColor: AppColor.white,
            validator: (val) {
              if (nameController.nameFieldController.value.text.isEmpty) {
                return CommonString.nameCanNotEmpty;
              }
            },
            controller: nameController.nameFieldController.value,
          ),
        ),
        const Gap(24),
        Obx(
          () => CommonAppButton(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                await nameController.updateProfile(
                  context: context,
                  name: nameController.nameFieldController.value.text.trim(),
                );
              }
            },
            text: CommonString.completeSetup,
            buttonType: nameController.isLoading.value
                ? ButtonType.progress
                : ButtonType.enable,
          ),
        ),
      ],
    );
  }
}
