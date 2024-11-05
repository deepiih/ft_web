import 'package:sectar_web/package/config_packages.dart';

class AddNoteDialog extends StatelessWidget {
  AddNoteDialog(
      {super.key,
      this.onCancelTap,
      required this.onSendTap,
      this.buttonType,
      this.title,
      this.note,
      this.textEditingController,
      this.textInputFormatter,
      this.buttonText,
      this.icon,
      this.iconColor,
      this.maxLine,
      this.hintText,
      this.errorText,
      this.content});

  final Function()? onCancelTap;
  final Function(String) onSendTap;
  final ButtonType? buttonType;
  final String? title, note, buttonText, icon, content;
  final Color? iconColor;
  final int? maxLine;
  final TextEditingController? textEditingController;
  final List<TextInputFormatter>? textInputFormatter;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String? hintText, errorText;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: false,
      ),
      child: AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColor.white,
        content: SizedBox(
          width: MediaQuery.of(context).size.width * .28,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  icon ?? AppImage.mail,
                  height: 40,
                  color: iconColor ?? AppColor.textSecondaryColor,
                ),
                const Gap(24),
                Text(
                  title ?? "Are you sure to send a project to review?",
                  style: const TextStyle()
                      .normal20w400
                      .textColor(AppColor.lightBlackColor),
                ),
                const Gap(15),
                Visibility(
                  visible: ((note ?? "").isNotEmpty),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        child: SizedBox(
                          width: 400,
                          child: InputField(
                            hint: hintText ?? "Specify changes",
                            validator: (val) {
                              if (textEditingController!.text.isEmpty) {
                                return errorText ?? "Please add a note";
                              }
                            },
                            inputFormatter: textInputFormatter ??
                                [FirstLetterCapitalFormatter()],
                            controller: textEditingController!,
                            maxLine: maxLine ?? 4,
                          ),
                        ),
                      ),
                      const Gap(16),
                      Text(
                        note ?? "",
                        style: const TextStyle()
                            .normal18w400
                            .textColor(AppColor.textSecondaryColor),
                      ),
                      const Gap(16),
                    ],
                  ),
                ),
                Visibility(
                  visible: ((content ?? "").isNotEmpty),
                  child: Column(
                    children: [
                      const Gap(16),
                      Text(
                        content ?? "",
                        style: const TextStyle()
                            .normal18w400
                            .textColor(AppColor.textSecondaryColor),
                      ),
                      const Gap(16),
                    ],
                  ),
                ),
                const Gap(24),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: CommonBackButton(
                    text: 'Cancel',
                    onTap: onCancelTap,
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: CommonAppButton(
                    buttonType: buttonType == ButtonType.progress
                        ? ButtonType.progress
                        : ButtonType.enable,
                    text: buttonText ?? 'Send',
                    onTap: () {
                      if ((note ?? "").isNotEmpty) {
                        if (_formKey.currentState!.validate()) {
                          onSendTap(textEditingController?.text ?? "");
                        }
                      } else {
                        onSendTap(textEditingController?.text ?? "");
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
