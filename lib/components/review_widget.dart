import 'package:sectar_web/package/config_packages.dart';

class AutoPay {
  String? title;
  bool? isSelected;

  AutoPay({this.title, this.isSelected});
}

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({
    super.key,
    this.title,
    this.subtitle,
    this.projectName,
    this.projectBudget,
    this.firstMileStoneBudget,
    this.mileStoneName,
    this.deliverablesList,
    this.attachmentList,
    this.tentativeStartDate,
    this.projectNotes,
    this.clientVendorName,
    this.clientVendorEmail,
    this.isClient,
    this.autoPayChildWidget,
    this.mileStoneBudgetTitle,
    this.mileStoneDetailTitle,
    this.mileStoneStartDate,
    this.mileStoneEndDate,
    this.isShowAutoPayWidget,
  });

  final String? title;
  final Widget? subtitle;
  final String? projectName;
  final String? projectBudget;
  final String? firstMileStoneBudget;
  final String? mileStoneName;
  final String? projectNotes;
  final String? tentativeStartDate;
  final String? clientVendorName;
  final String? clientVendorEmail;
  final String? mileStoneBudgetTitle;
  final String? mileStoneDetailTitle;
  final String? mileStoneStartDate;
  final String? mileStoneEndDate;
  final Widget? autoPayChildWidget;

  final bool? isClient;
  final bool? isShowAutoPayWidget;
  final List<dynamic>? deliverablesList;
  final List<dynamic>? attachmentList;

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.title ?? "",
          style: const TextStyle().normal24w700.textColor(AppColor.lightBlackColor),
        ),
        const Gap(16),
        if (widget.subtitle != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.subtitle ?? const Text(""),
              const Gap(32),
            ],
          ),
        _projectInfo(),
        const Gap(24),
        _projectMileStone(widget.isClient ?? false),
        if ((widget.attachmentList ?? []).isNotEmpty) ...[
          const Gap(24),
          _fileAttachment(),
        ],
        const Gap(24),
        _projectNotes(),
        const Gap(24),
        _clientInfo(),
        const Gap(24),
        if (widget.isClient ?? false) ...[
          if (widget.isShowAutoPayWidget == true) ...[
            _autoPayClient(),
          ]
        ] else ...[
          _autoPayFreelancer(),
        ]
      ],
    );
  }

  Row _autoPayFreelancer() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColor.backgroundStokeColor,
                width: 0.9,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "AUTO PAY",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(24),
                Text(
                  "Auto pay is enabled by default. The client can\nchoose between 1, 3, 7 or 10 days as the project\nauto-pay setting.",
                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                ),
                const Gap(32),
                Text(
                  "See a sample of what the client sees",
                  style: const TextStyle().normal16w400.textColor(AppColor.primaryColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _autoPayClient() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColor.backgroundStokeColor,
                width: 0.9,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SELECT AUTO PAY",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(24),
                Text(
                  "Choose between 1, 3, 7 or 10 days as the project auto-pay setting.",
                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                ),
                const Gap(32),
                Text(
                  "Learn about Autopay",
                  style: const TextStyle().normal16w400.textColor(AppColor.primaryColor),
                ),
                const Gap(32),
                widget.autoPayChildWidget ?? const Text("")
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _clientInfo() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColor.backgroundStokeColor,
                width: 0.9,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isClient ?? false ? "VENDOR INFO" : "CLIENT INFO",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(24),
                Text(
                  widget.isClient ?? false ? "VENDOR NAME" : "CLIENT NAME",
                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                ),
                const Gap(8),
                Text(
                  widget.clientVendorName ?? "",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(20),
                Text(
                  "EMAIL",
                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                ),
                const Gap(8),
                Text(
                  widget.clientVendorEmail ?? "",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _fileAttachment() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColor.backgroundStokeColor,
                width: 0.9,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ATTACHMENT",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(24),
                ListView.separated(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                            widget.attachmentList?[index] ?? "",
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.attachmentList?[index] ?? "",
                              style: const TextStyle().normal16w400.textColor(AppColor.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(
                        height: 1,
                        color: AppColor.backgroundStokeColor,
                      ),
                    );
                  },
                  itemCount: widget.attachmentList?.length ?? 0,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _projectNotes() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColor.backgroundStokeColor,
                width: 0.9,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PROJECT NOTES",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(16),
                Text(
                  widget.projectNotes ?? "",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _projectMileStone(bool isClient) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColor.backgroundStokeColor,
                width: 0.9,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.mileStoneDetailTitle ?? "",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(16),
                Text(
                  widget.mileStoneName ?? "",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(8),
                Text(
                  "This is only a ballpark number. You can change\nthis later at will by adding and updating\nmilestones.",
                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                ),
                Visibility(
                  visible: ((widget.mileStoneStartDate ?? "").isNotEmpty && (widget.mileStoneEndDate ?? "").isNotEmpty),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(24),
                      Text(
                        "START DATE",
                        style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                      ),
                      const Gap(8),
                      Text(
                        widget.mileStoneStartDate ?? "",
                        style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                      ),
                      const Gap(24),
                      Text(
                        "End date",
                        style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                      ),
                      const Gap(8),
                      Text(
                        widget.mileStoneEndDate ?? "",
                        style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                      ),
                    ],
                  ),
                ),
                const Gap(52),
                Text(
                  "DELIVERABLES",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(20),
                ListView.separated(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.deliverablesList?[index] ?? "",
                            style: const TextStyle().normal16w400.textColor(AppColor.lightBlackColor),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(
                        height: 1,
                        color: AppColor.backgroundStokeColor,
                      ),
                    );
                  },
                  itemCount: widget.deliverablesList?.length ?? 0,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _projectInfo() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColor.backgroundStokeColor,
                width: 0.9,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PROJECT INFO",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(24),
                Text(
                  "PROJECT NAME",
                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                ),
                const Gap(8),
                Text(
                  widget.projectName ?? "",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(20),
                Text(
                  "PROJECT BUDGET",
                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                ),
                const Gap(8),
                Text(
                  "${widget.projectBudget}",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
                const Gap(20),
                Text(
                  widget.mileStoneBudgetTitle ?? "",
                  style: const TextStyle().normal16w400.textColor(AppColor.textSecondaryColor),
                ),
                const Gap(8),
                Text(
                  "${widget.firstMileStoneBudget}",
                  style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
