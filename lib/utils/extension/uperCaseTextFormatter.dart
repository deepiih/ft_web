import 'package:sectar_web/package/config_packages.dart';


class FirstLetterCapitalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    if (newText.isNotEmpty) {
      newText = newText[0].toUpperCase() + newText.substring(1);
    }

    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }
}
