import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.put<ProfileController>(ProfileController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    profileController.nameController.value.text = AppPref().name;
    profileController.emailController.value.text = AppPref().email;
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ProfileController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: const TextStyle().normal24w700.textColor(AppColor.lightBlackColor),
          ),
          const Gap(32),
          Text(
            'BASIC INFORMATION',
            style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
          ),
          const Gap(24),
          Text(
            'NAME',
            style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
          ),
          const Gap(12),
          SizedBox(
            width: 390,
            child: Form(
              key: _formKey,
              child: InputField(
                onSubmitted: (val) async {},
                disable: true,
                keyboardType: TextInputType.name,
                hint: CommonString.enterName,
                fillColor: AppColor.white,
                validator: (val) {
                  if (profileController.nameController.value.text.isEmpty) {
                    return CommonString.nameCanNotEmpty;
                  }
                },
                controller: profileController.nameController.value,
              ),
            ),
          ),
          const Gap(24),
          Text(
            'Email address',
            style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
          ),
          const Gap(12),
          SizedBox(
            width: 390,
            child: InputField(
              disable: true,
              keyboardType: TextInputType.emailAddress,
              hint: CommonString.enterYourEmail,
              fillColor: AppColor.white,
              validator: (val) {
                if (profileController.emailController.value.text.isEmpty) {
                  return CommonString.emailCanNotEmpty;
                } else if (!(profileController.emailController.value.text.isEmail)) {
                  return CommonString.plsEnterValidEmailAddress;
                }
              },
              controller: profileController.emailController.value,
            ),
          ),
          const Gap(24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONNECTED BANK DETAILS',
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(16),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 20,
                        AppImage.nextButton,
                      ),
                      const Gap(8),
                      Text(
                        CommonString.viewDashboardOnStripe,
                        style: const TextStyle().normal16w400.textColor(AppColor.primaryColor),
                      ),
                    ],
                  ),
                ),
                const Gap(50),
                Text(
                  'PAYOUT SCHEDULE',
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(24),
                Text(
                  CommonString.dailyPayoutEnabled,
                  style: const TextStyle().normal20w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(8),
                Text(
                  'We process funds to your account on daily basis',
                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                ),
                const Gap(20),
                Text(
                  'Learn more about Daily Payouts',
                  style: const TextStyle().normal16w400.textColor(AppColor.primaryColor),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
