// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:sectar_web/package/config_packages.dart';

extension BuildContextExt on BuildContext {
  /// Returns same as MediaQuery.of(context)
  MediaQueryData get mq => MediaQuery.of(this);

  /// Returns if Orientation is landscape
  bool get isLandscape => mq.orientation == Orientation.landscape;

  double get statusBarHeight => mq.padding.top;

  double get navigationBarHeight => mq.padding.bottom;

  bool get isKeyboardOpen => 0 < mq.viewInsets.bottom;

  /// Returns same as Keyboard size in px
  double get keyboardHeightPx => mq.viewInsets.bottom;

  /// Returns same as Keyboard size in point
  double get keyboardHeight {
    var actualKeyboardHeight = mq.viewInsets.bottom;
    if (actualKeyboardHeight == 0) return 0.0;
    return mq.size.height * (actualKeyboardHeight / window.physicalSize.height);
  }

  SystemUiOverlayStyle get systemOverlayStyle => mq.platformBrightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

  //ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  double get bottomPadding => mediaQuery.padding.bottom;

  double get bottomInset => mediaQuery.viewInsets.bottom;

  double bottomPaddingIfNeeded(double defaultPadding) {
    return (0 < mediaQuery.padding.bottom) ? mediaQuery.padding.bottom : defaultPadding;
  }
}

extension $KotlinStyleExtension<T> on T {
  T let(void Function(T) func) {
    func(this);
    return this;
  }

  T apply(void Function() func) {
    func();
    return this;
  }

  R also<R>(R Function(T) func) {
    return func(this);
  }

  R run<R>(R Function() func) {
    return func();
  }
}
