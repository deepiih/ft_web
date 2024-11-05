import 'package:sectar_web/package/config_packages.dart';

class Constant {
  static const String fontFamily = "Bicyclette";
}

extension TextStyleExtensions on TextStyle {
  TextStyle get bold => weight(FontWeight.w600);

  TextStyle get normal24w700 => customStyle(
        fontSize: 24,
        letterSpacing: 0.0,
        weight: FontWeight.w700,
      );
  TextStyle get normal20w700 => customStyle(
    fontSize: 20,
    letterSpacing: 0.0,
    weight: FontWeight.w700,
  );

  TextStyle get normal20w500 => customStyle(
        fontSize: 20,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );

  TextStyle get normal18w700 => customStyle(
        fontSize: 18,
        letterSpacing: 0.0,
        weight: FontWeight.w700,
      );

  TextStyle get normal28w700 => customStyle(
        fontSize: 28,
        letterSpacing: 0.0,
        weight: FontWeight.w700,
      );

  TextStyle get normal16w700 => customStyle(
        fontSize: 16,
        letterSpacing: 0.0,
        weight: FontWeight.w700,
      );

  TextStyle get normal24w500 => customStyle(
        fontSize: 24,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );

  TextStyle get normal16w500 => customStyle(
        fontSize: 16,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );

  TextStyle get normal16w600 => customStyle(
        fontSize: 16,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );

  TextStyle get normal10w500 => customStyle(
        fontSize: 10,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );

  TextStyle get normal21w700 => customStyle(
        fontSize: 21,
        letterSpacing: 0.0,
        weight: FontWeight.w700,
      );

  TextStyle get normal21w400 => customStyle(
        fontSize: 21,
        letterSpacing: 0.0,
        weight: FontWeight.w400,
      );

  TextStyle get normal32w600 => customStyle(
        fontSize: 32,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );

  TextStyle get normal32w700 => customStyle(
        fontSize: 32,
        letterSpacing: 0.0,
        weight: FontWeight.w700,
      );

  TextStyle get normal22w600 => customStyle(
        fontSize: 22,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );

  TextStyle get normal36w600 => customStyle(
        fontSize: 36,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );

  TextStyle get normal22w700 => customStyle(
        fontSize: 22,
        letterSpacing: 0.0,
        weight: FontWeight.w700,
      );

  TextStyle get normal13w500 => customStyle(
        fontSize: 13,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );

  TextStyle get normal11w600 => customStyle(
        fontSize: 11,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );

  TextStyle get normal18w600 => customStyle(
        fontSize: 18,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );

  TextStyle get normal18w500 => customStyle(
        fontSize: 18,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );

  TextStyle get normal8w500 => customStyle(
        fontSize: 8,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );

  TextStyle get normal12w500 => customStyle(
        fontSize: 12,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );

  TextStyle get normal12w700 => customStyle(
        fontSize: 12,
        letterSpacing: 0.0,
        weight: FontWeight.w700,
      );

  TextStyle get normal12w600 => customStyle(
        fontSize: 12,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );

  TextStyle get normal12w400 => customStyle(
        fontSize: 12,
        letterSpacing: 0.0,
        weight: FontWeight.w400,
      );

  TextStyle get normal24w600 => customStyle(
        fontSize: 24,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );

  TextStyle get normal20w600 => customStyle(
        fontSize: 20,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );

  TextStyle get normal42w600 => customStyle(
        fontSize: 42,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );

  TextStyle get normal42w400 => customStyle(
        fontSize: 42,
        letterSpacing: 0.0,
        weight: FontWeight.w400,
      );

  TextStyle get normal14w400 => customStyle(
        fontSize: 14,
        letterSpacing: 0.0,
        weight: FontWeight.w400,
      );

  TextStyle get normal14w600 => customStyle(
        fontSize: 14,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );

  TextStyle get normal14w700 => customStyle(
        fontSize: 14,
        letterSpacing: 0.0,
        weight: FontWeight.w700,
      );

  TextStyle get normal14w500 => customStyle(
        fontSize: 14,
        letterSpacing: 0.0,
        weight: FontWeight.w500,
      );

  TextStyle get normal11w400 => customStyle(
        fontSize: 11,
        letterSpacing: 0.0,
        weight: FontWeight.w400,
      );

  TextStyle get normal18w400 => customStyle(
        fontSize: 18,
        letterSpacing: 0.0,
        weight: FontWeight.w400,
      );

  TextStyle get normal24w400 => customStyle(
        fontSize: 24,
        letterSpacing: 0.0,
        weight: FontWeight.w400,
      );

  TextStyle get normal20w400 => customStyle(
        fontSize: 20,
        letterSpacing: 0.0,
        weight: FontWeight.w400,
      );

  TextStyle get normal16w400 => customStyle(
        fontSize: 16,
        letterSpacing: 0.0,
        weight: FontWeight.w400,
      );

  TextStyle get normal30w600 => customStyle(
        fontSize: 30,
        letterSpacing: 0.0,
        weight: FontWeight.w600,
      );

  TextStyle get normal15w700 => customStyle(
        fontSize: 17,
        letterSpacing: 0.0,
        weight: FontWeight.w700,
      );

  TextStyle textColor(Color v) => copyWith(color: v);

  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);

  TextStyle size(double v) => copyWith(fontSize: v);

  TextStyle letterSpace(double v) => copyWith(letterSpacing: v);

  TextStyle customStyle({
    required double letterSpacing,
    required double fontSize,
    required FontWeight weight,
  }) =>
      copyWith(
        letterSpacing: letterSpacing,
        fontSize: fontSize,
        fontWeight: weight,
        fontFamily: Constant.fontFamily,
      );
}
