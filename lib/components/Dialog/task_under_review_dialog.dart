
import 'package:sectar_web/package/config_packages.dart';
import 'package:sectar_web/package/screen_packages.dart';

class TaskUnderReviewDialog extends StatefulWidget {
  const TaskUnderReviewDialog({
    super.key,
    this.availableBudget,
    this.isClient = false,
    required this.onDoneTap,
    required this.buttonType,
    this.onDeleteTap,
    this.onReqChange,
    this.onApproveTask,
    this.task,
  });

  final bool? isClient;
  final String? availableBudget;
  final Function(Task) onDoneTap;
  final Function()? onDeleteTap;
  final ButtonType buttonType;
  final Task? task;

  final Function()? onReqChange;
  final Function()? onApproveTask;

  @override
  State<TaskUnderReviewDialog> createState() => _TaskUnderReviewDialogState();
}

class _TaskUnderReviewDialogState extends State<TaskUnderReviewDialog> {
  String selectedStatus = "";
  String selectedBudget = "";
  String availableBudget = "";
  String taskTitle = "";
  String taskDescription = "";
  DateTime? selectedDate;

  @override
  void initState() {
    taskTitle = widget.task?.taskName ?? "";
    taskDescription = widget.task?.description ?? "";
    selectedStatus = widget.task?.taskStatus ?? "";
    selectedBudget = widget.task?.taskBudget.toString() ?? "";
    selectedDate = DateTime.parse(widget.task?.dueDate ?? "");
    availableBudget = (int.parse(widget.availableBudget ?? "") +
            int.parse(widget.task?.taskBudget.toString() ?? ""))
        .toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: false,
      ),
      child: SimpleDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColor.white,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'T-${widget.task?.id.toString()}',
                      style: const TextStyle()
                          .normal16w400
                          .textColor(AppColor.textSecondaryColor),
                    ),
                    if ((widget.isClient ?? false) == false)
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AddTaskDialog(
                                  task: widget.task,
                                  buttonType: ButtonType.enable,
                                  onTap: (Task data) async {
                                    taskTitle = data.taskName ?? "";
                                    taskDescription = data.description ?? "";
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                );
                              });
                        },
                        child: const Icon(
                          Icons.edit,
                          size: 20,
                          color: AppColor.textSecondaryColor,
                        ),
                      ),
                  ],
                ),
                const Gap(16),
                Text(
                  taskTitle,
                  style: const TextStyle()
                      .normal20w700
                      .textColor(AppColor.lightBlackColor),
                ),
                const Gap(8),
                Text(
                  taskDescription,
                  style: const TextStyle()
                      .normal18w400
                      .textColor(AppColor.textSecondaryColor),
                ),
                const Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "STATUS",
                      style: const TextStyle()
                          .normal16w400
                          .textColor(AppColor.textSecondaryColor),
                    ),
                    _status(context),
                  ],
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "DUE DATE",
                      style: const TextStyle()
                          .normal16w400
                          .textColor(AppColor.textSecondaryColor),
                    ),
                    _dueDate(),
                  ],
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TASK VALUE",
                      style: const TextStyle()
                          .normal16w400
                          .textColor(AppColor.textSecondaryColor),
                    ),
                    _taskValue(),
                  ],
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "AUTO PAY",
                      style: const TextStyle()
                          .normal16w400
                          .textColor(AppColor.textSecondaryColor),
                    ),
                    _autoPay(),
                  ],
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "AUTO PAYOUT",
                      style: const TextStyle()
                          .normal16w400
                          .textColor(AppColor.textSecondaryColor),
                    ),
                    _autoPayOut(),
                  ],
                ),
                const Gap(38),
                if ((widget.isClient ?? false) &&
                    widget.task?.taskStatus?.toLowerCase() ==
                        underReview.toLowerCase()) ...[
                  _clientButton(context)
                ] else if (!(widget.isClient ?? false)) ...[
                  _freelancerButton(context),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _clientButton(BuildContext context) {
    return Row(
      children: [
        CommonAppButton(
          height: 40,
          width: 151,
          isAddButton: true,
          buttonColor: AppColor.orangeColor,
          buttonType: ButtonType.enable,
          onTap: widget.onReqChange,
          text: "Request changes",
        ),
        const Gap(16),
        CommonAppButton(
          height: 40,
          width: 151,
          isAddButton: true,
          buttonColor: AppColor.successStatusColor,
          buttonType: ButtonType.enable,
          onTap: widget.onApproveTask,
          text: "Approve task",
        ),
      ],
    );
  }

  Row _freelancerButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CommonBackButton(
              height: 40,
              width: 66,
              text: "Cancel",
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Gap(16),
            CommonAppButton(
              height: 40,
              width: 70,
              buttonType: widget.buttonType == ButtonType.enable
                  ? ButtonType.enable
                  : ButtonType.progress,
              onTap: () {
                Task data = Task(
                    dueDate: DateFormat(CommonDateFormat.dd_MM_yyyy)
                        .format(selectedDate ?? DateTime.now()),
                    taskBudget: int.parse(selectedBudget.toString()),
                    taskStatus: selectedStatus,
                    taskName: taskTitle,
                    description: taskDescription);
                widget.onDoneTap(data);
              },
              text: "Save",
            ),
          ],
        ),
        GestureDetector(
          onTap: widget.onDeleteTap,
          child: Image.asset(
            height: 25,
            AppImage.delete,
          ),
        ),
      ],
    );
  }

  Center _autoPayOut() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Text(
          widget.task?.autoPayDate == null
              ? "n/a"
              : DateFormat(CommonDateFormat.E_d_MMMM_y)
                  .format(DateTime.parse(widget.task?.autoPayDate ?? "")),
          textAlign: TextAlign.start,
          style: const TextStyle()
              .normal16w400
              .textColor(AppColor.lightBlackColor),
        ),
      ),
    );
  }

  Container _autoPay() {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.successStatusColor,
          borderRadius: BorderRadius.circular(48)),
      height: 35,
      width: 56,
      child: Center(
        child: Text(
          "On",
          style: const TextStyle().normal16w400.textColor(AppColor.white),
        ),
      ),
    );
  }

  GestureDetector _taskValue() {
    return GestureDetector(
      onTap: widget.isClient ?? false
          ? () {}
          : () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return TaskValueDialog(
                      taskValue: selectedBudget,
                      availableBudget: availableBudget,
                      onDonePressed: (val1, val2) {
                        selectedBudget = val1;
                        availableBudget = val2;
                        setState(() {});
                      },
                    );
                  });
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            color: AppColor.lightBlackColor),
        child: Row(
          children: [
            Image.asset(
              AppImage.dollar,
              color: AppColor.white,
              height: 20,
            ),
            const Gap(8),
            Text(
              selectedBudget.isNotEmpty ? '\$$selectedBudget' : "Value",
              textAlign: TextAlign.center,
              style: const TextStyle().normal16w400.textColor(AppColor.white),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _dueDate() {
    return GestureDetector(
      onTap: widget.isClient ?? false
          ? () {}
          : () async {
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
                selectedDate != null
                    ? DateFormat(CommonDateFormat.E_d_MMMM_y)
                        .format(selectedDate!)
                    : "Due date",
                textAlign: TextAlign.center,
                style: const TextStyle()
                    .normal16w400
                    .textColor(AppColor.lightBlackColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _status(context) {
    return GestureDetector(
      onTap: widget.isClient ?? false
          ? () {}
          : () async {
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
                style: const TextStyle()
                    .normal16w400
                    .textColor(AppColor.lightBlackColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
