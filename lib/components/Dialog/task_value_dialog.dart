import 'package:sectar_web/package/config_packages.dart';

class TaskValueDialog extends StatefulWidget {
  const TaskValueDialog(
      {super.key,
      required this.onDonePressed,
      this.availableBudget,
      this.taskValue});

  final Function(String, String) onDonePressed;
  final String? availableBudget;
  final String? taskValue;

  @override
  State<TaskValueDialog> createState() => _TaskValueDialogState();
}

class _TaskValueDialogState extends State<TaskValueDialog> {
  final TextEditingController budgetController = TextEditingController();
  String? availableBudget;
  bool isButtonEnabled = false;

  @override
  void initState() {
    availableBudget = widget.availableBudget;
    budgetController.text = widget.taskValue ?? "";
    if ((widget.taskValue ?? "").isNotEmpty &&
        double.parse(availableBudget ?? "0.0") >
            double.parse(widget.taskValue ?? "0.0")) {
      availableBudget = (double.parse(availableBudget ?? "0.0") -
              double.parse(widget.taskValue ?? "0.0"))
          .toString();
      isButtonEnabled = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: false,
      ),
      child: SimpleDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColor.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: Responsive.isDesktop(context)?400:300,
                  child: InputField(
                    onChange: (val) {
                      setState(() {
                        isButtonEnabled = false;

                        if (val == null || val.isEmpty) {
                          availableBudget = widget.availableBudget;
                        } else {
                          double currentBudget =
                              double.parse(widget.availableBudget ?? "0.0");
                          double taskValue = double.parse(val);
                          if (taskValue > currentBudget) {
                            showAnimationToast(
                              context: context,
                              msg: 'Task value cannot exceed available budget',
                              isForError: true,
                            );
                          } else {
                            availableBudget =
                                (currentBudget - taskValue).toString();
                            isButtonEnabled = true;
                          }
                        }
                      });
                    },
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    controller: budgetController,
                    hint: 'Enter task value',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset(
                        AppImage.dollar1,
                        height: 18,
                        width: 18,
                        color: AppColor.textSecondaryColor,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset(
                        AppImage.dollar,
                        height: 20,
                        width: 20,
                        color: AppColor.textSecondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(16),
            Text(
              "Funds available to allocate : \$$availableBudget",
              style: const TextStyle().normal16w400.textColor(
                    AppColor.textSecondaryColor,
                  ),
            ),
            const Gap(24),
            Row(
              children: [
                Expanded(
                  child: CommonAppButton(
                    onTap: () {
                      widget.onDonePressed(
                          budgetController.text, availableBudget ?? '');
                      Navigator.pop(context);
                    },
                    text: 'Done',
                    buttonType: isButtonEnabled
                        ? ButtonType.enable
                        : ButtonType.disable,
                  ),
                ),
              ],
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
