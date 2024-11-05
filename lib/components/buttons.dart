import 'package:sectar_web/package/config_packages.dart';

class CommonAppButton extends StatelessWidget {
  final Function()? onTap;
  final ButtonType buttonType;
  final String? text;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final TextStyle? style;
  final double? borderRadius;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final bool? isAddButton;
  final Color? buttonColor;
  final Color? disableButtonColor;

  const CommonAppButton({
    super.key,
    this.onTap,
    this.buttonType = ButtonType.disable,
    this.text,
    this.color,
    this.icon,
    this.height,
    this.textColor,
    this.style,
    this.borderRadius,
    this.width,
    this.boxShadow,
    this.border,
    this.isAddButton,
    this.buttonColor,
    this.disableButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    Color background = disableButtonColor ?? AppColor.textSecondaryColor;
    switch (buttonType) {
      case ButtonType.enable:
        {
          if (isAddButton == true) {
            background = buttonColor!;
          } else {
            background = AppColor.primaryColor;
          }
        }
        break;
      case ButtonType.disable:
        {
          background = disableButtonColor ?? AppColor.textSecondaryColor;
        }
        break;
      case ButtonType.progress:
        break;
    }
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        onTap: (buttonType == ButtonType.enable) ? (onTap ?? () {}) : () {},
        child: Container(
          height: height ?? 47,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: null,
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            boxShadow: boxShadow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (buttonType == ButtonType.progress)
                const SizedBox(
                  height: 30,
                  width: 30,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              if (buttonType != ButtonType.progress)
                Center(
                  child: Text(
                    text!,
                    style: style ?? const TextStyle().normal18w400.textColor(AppColor.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({super.key, this.text, this.onTap, this.width, this.height});

  final String? text;
  final double? width,height;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          height: height??47,

          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: null,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(blurRadius: 1, offset: const Offset(0, 2), color: AppColor.black.withOpacity(0.11)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  text!,
                  style: const TextStyle().normal18w400.textColor(AppColor.textSecondaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
