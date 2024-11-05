import 'package:sectar_web/package/config_packages.dart';

typedef OnValidation = dynamic Function(String? text);

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool firstCapital;
  final bool disable;
  final bool readOnly;
  final String hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isHasInVisibleBorder;
  final List<TextInputFormatter>? inputFormatter;
  final OnValidation? validator;
  final Function(String?)? onChange;
  final Function(String?)? onSubmitted;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLine;
  final double? width;
  final double? height;
  final Color? textFieldColor;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final Color? borderColor;

  const InputField({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.focusNode,
    this.obscureText = false,
    this.disable = false,
    this.firstCapital = false,
    this.hint = "",
    this.onChange,
    this.fillColor,
    this.inputFormatter,
    this.onSubmitted,
    this.onTap,
    this.isHasInVisibleBorder = false,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.maxLine,
    this.width,
    this.height,
    this.textFieldColor,
    this.hintStyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 70,
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap ?? () {},
        textCapitalization: firstCapital ? TextCapitalization.words : TextCapitalization.none,
        cursorColor: AppColor.black,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        focusNode: focusNode,
        autofocus: false,
        obscureText: obscureText,
        maxLines: maxLine,
        inputFormatters: inputFormatter ?? [],
        style: const TextStyle().normal18w400.textColor(AppColor.lightBlackColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          prefixIcon: prefixIcon,
          isCollapsed: true,
          suffixIcon: suffixIcon,
          enabled: !disable,
          hintStyle: hintStyle ?? const TextStyle().normal18w400.textColor(AppColor.textSecondaryColor),
          hintText: hint,
          filled: true,
          fillColor: fillColor ?? AppColor.white,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1,
              color: AppColor.backgroundStokeColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1,
              color: AppColor.backgroundStokeColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1,
              color: AppColor.backgroundStokeColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1,
              color: AppColor.errorStatusColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1,
              color: AppColor.primaryColor,
            ),
          ),
        ),
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: keyboardType ?? TextInputType.name,
        onChanged: (val) {
          if (onChange != null) {
            onChange!(val);
          }
        },
        onFieldSubmitted: onSubmitted,
        validator: (val) {
          if (validator != null) {
            return validator!(val);
          } else {
            return null;
          }
        },
      ),
    );
  }
}
