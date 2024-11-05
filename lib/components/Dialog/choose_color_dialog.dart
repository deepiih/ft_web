import 'package:sectar_web/package/config_packages.dart';

class ChooseColorDialog extends StatelessWidget {
  const ChooseColorDialog({super.key, required this.onStatusSelected});

  final Function(String) onStatusSelected;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: false,
      ),
      child: SimpleDialog(
        contentPadding: const EdgeInsets.all(20),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColor.white,
        children: [
          Text(
            "SELECT STATUS",
            style: const TextStyle().normal20w400.textColor(AppColor.lightBlackColor),
          ),
          const Gap(24),
          Column(
            children: taskStatusList.map((e) {
              return GestureDetector(
                onTap: () {
                  onStatusSelected(e['status']);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: DottedBorder(
                    color: AppColor.backgroundStokeColor,
                    dashPattern: const [6, 6, 6, 6],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(48),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Container(
                              height: 20,
                              width: 20,
                              color: e['color'],
                            ),
                          ),
                          const Gap(12),
                          Text(
                            e['status'],
                            style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
