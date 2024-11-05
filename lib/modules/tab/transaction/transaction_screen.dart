import 'package:sectar_web/package/config_packages.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            "Transaction",
            style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
          ),
        ],
      ),
    );
  }
}
