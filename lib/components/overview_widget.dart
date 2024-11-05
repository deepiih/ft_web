import 'package:sectar_web/package/config_packages.dart';

class OverViewWidget extends StatelessWidget {
  const OverViewWidget({super.key, required this.overViewList});

  final List<OverView> overViewList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runAlignment: WrapAlignment.center,
      runSpacing: 10,
      spacing: 40,
      children: overViewList.map((e) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$${e.price??"0"}',
              style: const TextStyle().normal24w400.textColor(AppColor.black),
            ),
            const Gap(16),
            Text(
              e.title ?? "",
              style: const TextStyle().normal18w400.textColor(AppColor.textSecondaryColor),
            ),
          ],
        );
      }).toList(),
    );
  }
}
