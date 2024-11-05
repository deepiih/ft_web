import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';


class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({
    super.key,
    required this.onTap,
    required this.buttonType,
    this.availableBudget,
    this.task,
  });

  final Function(Task) onTap;
  final ButtonType buttonType;
  final String? availableBudget;
  final Task? task;

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController taskNameController = TextEditingController();
  String selectedStatus = "";
  String selectedBudget = "";
  String availableBudget = "";
  DateTime? selectedDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.task != null) {
      taskNameController.text = widget.task?.taskName ?? "";
      descriptionController.text = widget.task?.description ?? "";
    }

    availableBudget = widget.availableBudget ?? "";
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

        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColor.white,
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.task == null ? "Add Task" : "Edit Task",
                      style: const TextStyle().normal20w400.textColor(AppColor.lightBlackColor),
                    ),
                    const CloseTextButton(),
                  ],
                ),
                const Gap(16),
                SizedBox(
                  width: 500,
                  child: InputField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Task name can not be empty.';
                      }
                    },
                    maxLine: 1,
                    hint: 'Add a task name',
                    controller: taskNameController,
                    inputFormatter: [FirstLetterCapitalFormatter()],
                  ),
                ),
                const Gap(16),
                SizedBox(
                  width: 500,
                  child: InputField(
                    maxLine: 2,
                    hint: 'Add a description',
                    controller: descriptionController,
                    inputFormatter: [FirstLetterCapitalFormatter()],
                  ),
                ),
                Visibility(
                  visible: widget.task == null,
                  child: Column(
                    children: [
                      const Gap(16),
                      Row(
                        children: [
                          _dueDate(),
                          const Gap(16),

                          Visibility(visible: Responsive.isDesktop(context), child: _status(context),),
                          const Gap(16),
                          Visibility(
                            visible: Responsive.isDesktop(context),
                            child: _value(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Visibility(
                            visible: Responsive.isMobile(context),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                children: [
                                  _status(context),
                                  const Gap(10),
                                  _value(),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonAppButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.task == null) {
                            if (selectedStatus.isEmpty) {
                              showAnimationToast(
                                context: context,
                                msg: "Please select task status",
                                isForError: true,
                              );
                              return;
                            } else if (selectedBudget.isEmpty) {
                              showAnimationToast(
                                context: context,
                                msg: "Please select task budget",
                                isForError: true,
                              );
                              return;
                            }
                            Task data = Task(
                              taskName: taskNameController.value.text.trim(),
                              description: descriptionController.value.text.trim(),
                              dueDate: DateFormat(CommonDateFormat.dd_MM_yyyy).format(selectedDate ?? DateTime.now()),
                              taskBudget: int.parse(selectedBudget.toString()),
                              taskStatus: selectedStatus,
                            );
                            widget.onTap(data);
                          } else {
                            Task data = Task(
                              taskName: taskNameController.value.text.trim(),
                              description: descriptionController.value.text.trim(),
                            );
                            widget.onTap(data);
                          }
                        }
                      },
                      width: 100,
                      buttonType: widget.buttonType,
                      text: 'Save task',
                    ),
                    const Gap(20),
                    Visibility(
                      visible: widget.task == null,
                      child: Expanded(
                        child: Text(
                          "Funds available to allocate : \$$availableBudget",
                          style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _value() {
    return GestureDetector(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return TaskValueDialog(
                taskValue: selectedBudget,
                availableBudget: widget.availableBudget,
                onDonePressed: (val1, val2) {
                  selectedBudget = val1;
                  availableBudget = val2;
                  setState(() {});
                },
              );
            });
      },
      child: DottedBorder(
        color: AppColor.backgroundStokeColor,
        dashPattern: const [3, 3, 3, 3],
        borderType: BorderType.RRect,
        radius: const Radius.circular(48),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Row(
            children: [
              Image.asset(
                AppImage.dollar,
                color: AppColor.textSecondaryColor,
                height: 20,
              ),
              const Gap(8),
              Text(
                selectedBudget.isNotEmpty ? '\$$selectedBudget' : "Value",
                textAlign: TextAlign.center,
                style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _status(context) {
    return GestureDetector(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return ChooseColorDialog(
                onStatusSelected: (v) {
                  selectedStatus = v;
                  setState(() {});
                },
              );
            });
      },
      child: DottedBorder(
        color: AppColor.backgroundStokeColor,
        dashPattern: const [3, 3, 3, 3],
        borderType: BorderType.RRect,
        radius: const Radius.circular(48),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Row(
            children: [
              selectedStatus.isEmpty
                  ? Image.asset(
                AppImage.flag,
                color: AppColor.textSecondaryColor,
                height: 20,
              )
                  : ClipOval(
                child: Container(
                  height: 20,
                  width: 20,
                  color: getTaskStatusColor(selectedStatus),
                ),
              ),
              const Gap(8),
              Text(
                selectedStatus.isEmpty ? "Status" : selectedStatus,
                textAlign: TextAlign.center,
                style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _dueDate() {
    return GestureDetector(
      onTap: () async {
        selectedDate = await CommonDatePicker.selectDate(context);
        setState(() {});
      },
      child: DottedBorder(
        color: AppColor.backgroundStokeColor,
        dashPattern: const [3, 3, 3, 3],
        borderType: BorderType.RRect,
        radius: const Radius.circular(48),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Row(
            children: [
              Image.asset(
                AppImage.calendar,
                color: AppColor.textSecondaryColor,
                height: 20,
              ),
              const Gap(8),
              Text(
                selectedDate != null ? DateFormat('E d MMMM, y').format(selectedDate!) : "Due date",
                textAlign: TextAlign.center,
                style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
