import 'dart:math' as math;
import 'package:sectar_web/package/config_packages.dart';

typedef CustomAnimationBuilder = Widget Function(
  BuildContext context,
  AnimationController controller,
  Duration duration,
  Widget child,
);

Animation<T> getAnimation<T>(
  T start,
  T end,
  AnimationController controller, {
  Curve curve = Curves.linearToEaseOut,
}) {
  return controller.drive(Tween<T>(begin: start, end: end).chain(CurveTween(curve: curve)));
}

BuildContext? currentContext;
const _defaultDuration = Duration(milliseconds: 2300);
const animationDuration = Duration(milliseconds: 400);
const double _defaultHorizontalMargin = 50.0;

typedef OnInitStateCallback = Function(
  Duration toastDuration,
  Duration animDuration,
);

ToastFuture showToast(
  final String? msg,
  final String image, {
  BuildContext? context,
  final Duration? duration,
  final Duration? animDuration,
  StyledToastPosition? position,
  TextStyle? textStyle,
  EdgeInsetsGeometry? textPadding,
  final double toastHorizontalMargin = _defaultHorizontalMargin,
  Color? backgroundColor,
  BorderRadius? borderRadius,
  ShapeBorder? shapeBorder,
  final VoidCallback? onDismiss,
  TextDirection? textDirection,
  final bool? dismissOtherToast,
  final StyledToastAnimation? animation,
  final StyledToastAnimation? reverseAnimation,
  final Alignment? alignment,
  final Axis? axis,
  final Offset? startOffset,
  final Offset? endOffset,
  final Offset? reverseStartOffset,
  final Offset? reverseEndOffset,
  TextAlign? textAlign,
  final Curve? curve,
  final Curve? reverseCurve,
  bool? fullWidth,
  final bool? isHideKeyboard,
  final CustomAnimationBuilder? animationBuilder,
  final CustomAnimationBuilder? reverseAnimBuilder,
  final bool? isIgnoring,
  final OnInitStateCallback? onInitState,
  final double? imageHeight,
  final double? imageWidth,
  final Color? imageColor,
}) {
  context ??= currentContext;
  assert(context != null);

  final toastTheme = StyledToastTheme.maybeOf(context!);

  position ??= toastTheme?.toastPositions ?? StyledToastPosition.bottom;

  textStyle ??= toastTheme?.textStyle ??
      const TextStyle(
        fontSize: 16.0,
        color: AppColor.lightBlackColor,
        fontFamily: 'Bicyclette',
      );

  textPadding ??= toastTheme?.textPadding ?? const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0);

  backgroundColor ??= toastTheme?.backgroundColor ?? const Color(0x99000000);
  borderRadius ??= toastTheme?.borderRadius ?? BorderRadius.circular(5.0);

  shapeBorder ??= toastTheme?.shapeBorder ??
      RoundedRectangleBorder(
        borderRadius: borderRadius,
      );

  textDirection ??= toastTheme?.textDirection ?? TextDirection.ltr;

  textAlign ??= toastTheme?.textAlign ?? TextAlign.center;

  fullWidth ??= toastTheme?.fullWidth ?? false;

  final widget = Container(
    margin: EdgeInsets.symmetric(horizontal: toastHorizontalMargin),
    width: fullWidth ? MediaQuery.of(context).size.width - (toastHorizontalMargin) : null,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 2),
          color: Colors.black.withOpacity(0.11),
          blurRadius: 5,
          blurStyle: BlurStyle.outer,
          spreadRadius: 0,
        ),
      ],
      color: backgroundColor,
    ),
    padding: textPadding,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          image,
          height: imageHeight ?? 18,
          width: imageWidth ?? 18,
          color: imageColor ?? Colors.black,
        ),
        const SizedBox(width: 10),
        if (Responsive.isMobile(context)) ...[
          Expanded(
            child: Text(
              msg ?? '',
              style: textStyle,
              textAlign: textAlign,
            ),
          ),
        ] else ...[
          Text(
            msg ?? '',
            style: textStyle,
            textAlign: textAlign,
          ),
        ]
      ],
    ),
  );

  return showToastWidget(
    widget,
    context: context,
    duration: duration,
    animDuration: animDuration,
    onDismiss: onDismiss,
    position: position,
    dismissOtherToast: dismissOtherToast,
    textDirection: textDirection,
    alignment: alignment,
    axis: axis,
    startOffset: startOffset,
    endOffset: endOffset,
    reverseStartOffset: reverseStartOffset,
    reverseEndOffset: reverseEndOffset,
    curve: curve,
    reverseCurve: reverseCurve,
    animation: animation,
    reverseAnimation: reverseAnimation,
    isHideKeyboard: isHideKeyboard,
    animationBuilder: animationBuilder,
    reverseAnimBuilder: reverseAnimBuilder,
    isIgnoring: isIgnoring,
    onInitState: onInitState,
  );
}

ToastFuture showToastWidget(
  Widget widget, {
  BuildContext? context,
  Duration? duration,
  Duration? animDuration,
  VoidCallback? onDismiss,
  bool? dismissOtherToast,
  TextDirection? textDirection,
  Alignment? alignment,
  Axis? axis,
  Offset? startOffset,
  Offset? endOffset,
  Offset? reverseStartOffset,
  Offset? reverseEndOffset,
  StyledToastPosition? position,
  StyledToastAnimation? animation,
  StyledToastAnimation? reverseAnimation,
  Curve? curve,
  Curve? reverseCurve,
  bool? isHideKeyboard,
  CustomAnimationBuilder? animationBuilder,
  CustomAnimationBuilder? reverseAnimBuilder,
  bool? isIgnoring,
  OnInitStateCallback? onInitState,
}) {
  OverlayEntry entry;
  ToastFuture future;

  context ??= currentContext;
  assert(context != null);

  final toastTheme = StyledToastTheme.maybeOf(context!);

  isHideKeyboard ??= toastTheme?.isHideKeyboard ?? false;

  duration ??= toastTheme?.duration ?? _defaultDuration;

  animDuration ??= toastTheme?.animDuration ?? animationDuration;

  dismissOtherToast ??= toastTheme?.dismissOtherOnShow ?? true;

  textDirection ??= textDirection ?? toastTheme?.textDirection ?? TextDirection.ltr;

  position ??= toastTheme?.toastPositions ?? StyledToastPosition.bottom;

  alignment ??= toastTheme?.alignment ?? Alignment.center;

  axis ??= toastTheme?.axis ?? Axis.vertical;

  startOffset ??= toastTheme?.startOffset;

  endOffset ??= toastTheme?.endOffset;

  reverseStartOffset ??= toastTheme?.reverseStartOffset;

  reverseEndOffset ??= toastTheme?.reverseEndOffset;

  curve ??= curve ?? toastTheme?.curve ?? Curves.linear;

  reverseCurve ??= reverseCurve ?? toastTheme?.reverseCurve ?? Curves.linear;

  animation ??= animation ?? toastTheme?.toastAnimation ?? StyledToastAnimation.size;

  reverseAnimation ??= reverseAnimation ?? toastTheme?.reverseAnimation ?? StyledToastAnimation.size;

  animationBuilder ??= animationBuilder ?? toastTheme?.animationBuilder;

  reverseAnimBuilder ??= reverseAnimBuilder ?? toastTheme?.reverseAnimBuilder;

  onInitState ??= onInitState ?? toastTheme?.onInitState;

  onDismiss ??= onDismiss ?? toastTheme?.onDismiss;

  isIgnoring ??= toastTheme?.isIgnoring ?? true;

  if (isHideKeyboard) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  GlobalKey<StyledToastWidgetState> key = GlobalKey();

  entry = OverlayEntry(builder: (ctx) {
    return IgnorePointer(
      ignoring: isIgnoring!,
      child: _StyledToastWidget(
        duration: duration!,
        animDuration: animDuration!,
        position: position,
        animation: animation,
        reverseAnimation: reverseAnimation,
        alignment: alignment,
        axis: axis,
        startOffset: startOffset,
        endOffset: endOffset,
        reverseStartOffset: reverseStartOffset,
        reverseEndOffset: reverseEndOffset,
        curve: curve!,
        reverseCurve: reverseCurve!,
        key: key,
        animationBuilder: animationBuilder,
        reverseAnimBuilder: reverseAnimBuilder,
        onInitState: onInitState,
        child: Directionality(
          textDirection: textDirection!,
          child: Material(
            child: widget,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  });

  if (dismissOtherToast) {
    dismissAllToast();
  }

  future = ToastFuture.create(duration, entry, onDismiss, key);

  Overlay.of(context).insert(entry);
  ToastManager().addFuture(future);

  return future;
}

class StyledToast extends StatefulWidget {
  final Widget child;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final EdgeInsets? textPadding;
  final TextStyle? textStyle;
  final ShapeBorder? shapeBorder;
  final Duration? animDuration;
  final StyledToastPosition? toastPositions;
  final StyledToastAnimation? toastAnimation;
  final StyledToastAnimation? reverseAnimation;
  final Alignment? alignment;
  final Axis? axis;
  final Duration? duration;
  final Offset? startOffset;
  final Offset? endOffset;
  final Offset? reverseStartOffset;
  final Offset? reverseEndOffset;
  final Curve? curve;
  final Curve? reverseCurve;
  final VoidCallback? onDismiss;
  final bool? dismissOtherOnShow;
  final Locale locale;
  final bool? fullWidth;
  final bool? isHideKeyboard;
  final CustomAnimationBuilder? animationBuilder;
  final CustomAnimationBuilder? reverseAnimBuilder;
  final bool? isIgnoring;
  final OnInitStateCallback? onInitState;

  const StyledToast({
    super.key,
    required this.child,
    this.textAlign,
    this.textDirection,
    this.borderRadius,
    this.backgroundColor,
    this.textPadding,
    this.textStyle = const TextStyle(fontSize: 16.0, color: AppColor.lightBlackColor),
    this.shapeBorder,
    this.duration,
    this.animDuration,
    this.toastPositions,
    this.toastAnimation,
    this.reverseAnimation,
    this.alignment,
    this.axis,
    this.startOffset,
    this.endOffset,
    this.reverseStartOffset,
    this.reverseEndOffset,
    this.curve,
    this.reverseCurve,
    this.dismissOtherOnShow = true,
    this.onDismiss,
    required this.locale,
    this.fullWidth,
    this.isHideKeyboard,
    this.animationBuilder,
    this.reverseAnimBuilder,
    this.isIgnoring = true,
    this.onInitState,
  });

  @override
  State<StatefulWidget> createState() {
    return _StyledToastState();
  }
}

class _StyledToastState extends State<StyledToast> {
  @override
  Widget build(final BuildContext context) {
    final overlay = Overlay(
      initialEntries: <OverlayEntry>[
        OverlayEntry(builder: (context) {
          currentContext = context;
          return widget.child;
        })
      ],
    );

    final textDirection = widget.textDirection ?? TextDirection.ltr;

    final wrapper = Directionality(
      textDirection: textDirection,
      child: Stack(
        children: <Widget>[
          overlay,
        ],
      ),
    );

    final textStyle = widget.textStyle ??
        const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: AppColor.lightBlackColor,
        );

    final backgroundColor = widget.backgroundColor ?? const Color(0x99000000);

    final borderRadius = widget.borderRadius ?? BorderRadius.circular(5.0);

    final textAlign = widget.textAlign ?? TextAlign.center;
    final textPadding = widget.textPadding ??
        const EdgeInsets.symmetric(
          horizontal: 17.0,
          vertical: 8.0,
        );

    return Localizations(
      delegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: widget.locale,
      child: StyledToastTheme(
        textAlign: textAlign,
        textDirection: textDirection,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        textPadding: textPadding,
        textStyle: textStyle,
        shapeBorder: widget.shapeBorder,
        duration: widget.duration,
        animDuration: widget.animDuration,
        toastPositions: widget.toastPositions,
        toastAnimation: widget.toastAnimation,
        reverseAnimation: widget.reverseAnimation,
        alignment: widget.alignment,
        axis: widget.axis,
        startOffset: widget.startOffset,
        endOffset: widget.endOffset,
        reverseStartOffset: widget.reverseStartOffset,
        reverseEndOffset: widget.reverseEndOffset,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve,
        dismissOtherOnShow: widget.dismissOtherOnShow,
        onDismiss: widget.onDismiss,
        fullWidth: widget.fullWidth,
        isHideKeyboard: widget.isHideKeyboard,
        animationBuilder: widget.animationBuilder,
        reverseAnimBuilder: widget.reverseAnimBuilder,
        isIgnoring: widget.isIgnoring,
        onInitState: widget.onInitState,
        child: wrapper,
      ),
    );
  }
}

class _StyledToastWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration animDuration;
  final Curve curve;
  final Curve reverseCurve;
  final StyledToastPosition? position;
  final Alignment? alignment;
  final Axis? axis;
  final Offset? startOffset;
  final Offset? endOffset;
  final Offset? reverseStartOffset;
  final Offset? reverseEndOffset;
  final StyledToastAnimation? animation;
  final StyledToastAnimation? reverseAnimation;
  final CustomAnimationBuilder? animationBuilder;
  final CustomAnimationBuilder? reverseAnimBuilder;
  final OnInitStateCallback? onInitState;

  const _StyledToastWidget({
    super.key,
    required this.child,
    required this.duration,
    required this.animDuration,
    this.curve = Curves.linear,
    this.reverseCurve = Curves.linear,
    this.position = StyledToastPosition.bottom,
    this.alignment = Alignment.center,
    this.axis = Axis.horizontal,
    this.startOffset,
    this.endOffset,
    this.reverseStartOffset,
    this.reverseEndOffset,
    this.animation = StyledToastAnimation.fade,
    this.reverseAnimation,
    this.animationBuilder,
    this.reverseAnimBuilder,
    this.onInitState,
  }) : assert(animDuration * 2 <= duration || duration == Duration.zero);

  @override
  State<StatefulWidget> createState() {
    return StyledToastWidgetState();
  }
}

class StyledToastWidgetState extends State<_StyledToastWidget> with TickerProviderStateMixin<_StyledToastWidget>, WidgetsBindingObserver {
  late AnimationController _animationController;
  late AnimationController _reverseAnimController;
  late Animation<double> fadeAnim;
  late Animation<double> scaleAnim;
  late Animation<double> sizeAnim;
  late Animation<Offset> slideFromTopAnim;
  late Animation<Offset> slideFromBottomAnim;
  late Animation<Offset> slideFromLeftAnim;
  late Animation<Offset> slideFromRightAnim;
  late Animation<double> fadeScaleAnim;
  late Animation<double> rotateAnim;
  late Animation<double> fadeAnimReverse;
  late Animation<double> scaleAnimReverse;
  late Animation<double> sizeAnimReverse;
  late Animation<Offset> slideToTopAnimReverse;
  late Animation<Offset> slideToBottomAnimReverse;
  late Animation<Offset> slideToLeftAnimReverse;
  late Animation<Offset> slideToRightAnimReverse;
  late Animation<double> fadeScaleAnimReverse;
  late Animation<double> rotateAnimReverse;
  double opacity = 1.0;

  double? get offset => widget.position?.offset;

  Alignment? get positionAlignment => widget.position?.align;
  Timer? _toastTimer;

  @override
  void initState() {
    super.initState();
    _initAnim();
    _animationController.forward();
    widget.onInitState?.call(widget.duration, widget.animDuration);
    if (widget.duration != Duration.zero) {
      _toastTimer = Timer(widget.duration - widget.animDuration, () async {
        if (widget.reverseAnimation == StyledToastAnimation.none) {
          dismissToast();
        } else {
          dismissToastAnim();
        }
      });
    }

    WidgetsBinding.instance.addObserver(this);
  }

  void _initAnim() {
    _animationController = AnimationController(vsync: this, duration: widget.animDuration);

    _reverseAnimController = AnimationController(vsync: this, duration: widget.animDuration);

    switch (widget.animation) {
      case StyledToastAnimation.fade:
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve, reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.slideFromTop:
        slideFromTopAnim = _animationController.drive(
          Tween<Offset>(begin: widget.startOffset ?? const Offset(0.0, -1.0), end: widget.endOffset ?? Offset.zero).chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );
        break;
      case StyledToastAnimation.slideFromTopFade:
        slideFromTopAnim = _animationController.drive(
          Tween<Offset>(begin: widget.startOffset ?? const Offset(0.0, -1.0), end: widget.endOffset ?? Offset.zero).chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve, reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.slideFromBottom:
        slideFromBottomAnim = _animationController.drive(
          Tween<Offset>(begin: widget.startOffset ?? const Offset(0.0, 1.0), end: widget.endOffset ?? Offset.zero).chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );
        break;
      case StyledToastAnimation.slideFromBottomFade:
        slideFromBottomAnim = _animationController.drive(
          Tween<Offset>(begin: widget.startOffset ?? const Offset(0.0, 1.0), end: widget.endOffset ?? Offset.zero).chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve, reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.slideFromLeft:
        slideFromLeftAnim = _animationController.drive(
          Tween<Offset>(begin: widget.startOffset ?? const Offset(-1.0, 0.0), end: widget.endOffset ?? Offset.zero).chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );

        break;
      case StyledToastAnimation.slideFromLeftFade:
        slideFromLeftAnim = _animationController.drive(
          Tween<Offset>(begin: widget.startOffset ?? const Offset(-1.0, 0.0), end: widget.endOffset ?? Offset.zero).chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve, reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.slideFromRight:
        slideFromRightAnim = _animationController.drive(
          Tween<Offset>(begin: widget.startOffset ?? const Offset(1.0, 0.0), end: widget.endOffset ?? Offset.zero).chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );

        break;
      case StyledToastAnimation.slideFromRightFade:
        slideFromRightAnim = _animationController.drive(
          Tween<Offset>(begin: widget.startOffset ?? const Offset(1.0, 0.0), end: widget.endOffset ?? Offset.zero).chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve, reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.size:
        sizeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve, reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.sizeFade:
        sizeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve, reverseCurve: widget.reverseCurve),
        );

        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve, reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.scale:
        scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve, reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.fadeScale:
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ),
        );
        scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ),
        );
        break;
      case StyledToastAnimation.rotate:
        rotateAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve, reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.scaleRotate:
        scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ),
        );
        rotateAnim = Tween<double>(begin: 0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ),
        );
        break;
      case StyledToastAnimation.fadeRotate:
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ),
        );
        rotateAnim = Tween<double>(begin: 0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ),
        );
        break;
      case StyledToastAnimation.none:
        break;
      default:
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve, reverseCurve: widget.reverseCurve),
        );
        break;
    }

    if (widget.reverseAnimation != null) {
      switch (widget.reverseAnimation) {
        case StyledToastAnimation.fade:
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );

          break;
        case StyledToastAnimation.slideToTop:
          slideToTopAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
              begin: widget.reverseStartOffset ?? Offset.zero,
              end: widget.reverseEndOffset ?? const Offset(0.0, -1.0),
            ).chain(CurveTween(curve: widget.reverseCurve)),
          );

          break;
        case StyledToastAnimation.slideToTopFade:
          slideToTopAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
              begin: widget.reverseStartOffset ?? Offset.zero,
              end: widget.reverseEndOffset ?? const Offset(0.0, -1.0),
            ).chain(CurveTween(curve: widget.reverseCurve)),
          );
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.slideToBottom:
          slideToBottomAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
              begin: widget.reverseStartOffset ?? Offset.zero,
              end: widget.reverseEndOffset ?? const Offset(0.0, 1.0),
            ).chain(CurveTween(curve: widget.reverseCurve)),
          );
          break;
        case StyledToastAnimation.slideToBottomFade:
          slideToBottomAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
              begin: widget.reverseStartOffset ?? Offset.zero,
              end: widget.reverseEndOffset ?? const Offset(0.0, 1.0),
            ).chain(CurveTween(curve: widget.reverseCurve)),
          );
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.slideToLeft:
          slideToLeftAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
              begin: widget.reverseStartOffset ?? Offset.zero,
              end: widget.reverseEndOffset ?? const Offset(-1.0, 0.0),
            ).chain(CurveTween(curve: widget.reverseCurve)),
          );
          break;
        case StyledToastAnimation.slideToLeftFade:
          slideToLeftAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
              begin: widget.reverseStartOffset ?? Offset.zero,
              end: widget.reverseEndOffset ?? const Offset(-1.0, 0.0),
            ).chain(CurveTween(curve: widget.reverseCurve)),
          );
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.slideToRight:
          slideToRightAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
              begin: widget.reverseStartOffset ?? Offset.zero,
              end: widget.reverseEndOffset ?? const Offset(1.0, 0.0),
            ).chain(CurveTween(curve: widget.reverseCurve)),
          );
          break;
        case StyledToastAnimation.slideToRightFade:
          slideToRightAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
              begin: widget.reverseStartOffset ?? Offset.zero,
              end: widget.reverseEndOffset ?? const Offset(1.0, 0.0),
            ).chain(CurveTween(curve: widget.reverseCurve)),
          );
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.size:
          sizeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
              reverseCurve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.sizeFade:
          sizeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
              reverseCurve: widget.reverseCurve,
            ),
          );
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
              reverseCurve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.scale:
          scaleAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.fadeScale:
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
            ),
          );
          scaleAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
            ),
          );
          break;
        case StyledToastAnimation.rotate:
          rotateAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.scaleRotate:
          scaleAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
            ),
          );
          rotateAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
            ),
          );
          break;
        case StyledToastAnimation.fadeRotate:
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
            ),
          );
          rotateAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
            ),
          );
          break;
        case StyledToastAnimation.none:
          break;
        default:
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    Widget w = widget.child;

    if (widget.animationBuilder != null) {
      w = widget.animationBuilder!.call(context, _animationController, widget.duration, w);
    } else {
      w = createAnimWidget(w);
    }

    if (widget.reverseAnimBuilder != null) {
      w = widget.reverseAnimBuilder!.call(context, _reverseAnimController, widget.duration, w);
    } else {
      w = createReverseAnimWidget(w);
    }

    w = Opacity(
      opacity: opacity,
      child: w,
    );

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    w = Container(
      padding: EdgeInsets.only(bottom: mediaQueryData.padding.bottom, top: mediaQueryData.padding.top),
      alignment: positionAlignment,
      child: w,
    );

    if (Alignment.center == positionAlignment) {
    } else if (Alignment.bottomCenter == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(bottom: offset!),
        child: w,
      );
    } else if (Alignment.topCenter == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(top: offset!),
        child: w,
      );
    } else if (Alignment.topLeft == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(top: offset!),
        child: w,
      );
    } else if (Alignment.topRight == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(top: offset!),
        child: w,
      );
    } else if (Alignment.centerLeft == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(left: offset!),
        child: w,
      );
    } else if (Alignment.centerRight == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(right: offset!),
        child: w,
      );
    } else if (Alignment.bottomLeft == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(bottom: offset!),
        child: w,
      );
    } else if (Alignment.bottomRight == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(bottom: offset!),
        child: w,
      );
    } else {
      w = Padding(
        padding: EdgeInsets.all(offset!),
        child: w,
      );
    }

    return w;
  }

  Widget createAnimWidget(Widget w) {
    switch (widget.animation) {
      case StyledToastAnimation.fade:
        w = FadeTransition(
          opacity: fadeAnim,
          child: w,
        );
        break;
      case StyledToastAnimation.slideFromTop:
        w = SlideTransition(
          position: slideFromTopAnim,
          child: w,
        );
        break;
      case StyledToastAnimation.slideFromTopFade:
        w = SlideTransition(
          position: slideFromTopAnim,
          child: FadeTransition(
            opacity: fadeAnim,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.slideFromBottom:
        w = SlideTransition(
          position: slideFromBottomAnim,
          child: w,
        );
        break;
      case StyledToastAnimation.slideFromBottomFade:
        w = SlideTransition(
          position: slideFromBottomAnim,
          child: FadeTransition(
            opacity: fadeAnim,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.slideFromLeft:
        w = SlideTransition(
          position: slideFromLeftAnim,
          child: w,
        );
        break;
      case StyledToastAnimation.slideFromLeftFade:
        w = SlideTransition(
          position: slideFromLeftAnim,
          child: FadeTransition(
            opacity: fadeAnim,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.slideFromRight:
        w = SlideTransition(
          position: slideFromRightAnim,
          child: w,
        );
        break;
      case StyledToastAnimation.slideFromRightFade:
        w = SlideTransition(
          position: slideFromRightAnim,
          child: FadeTransition(
            opacity: fadeAnim,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.size:
        w = CustomSizeTransition(
          sizeFactor: sizeAnim,
          alignment: positionAlignment ?? Alignment.center,
          axisAlignment: 0.0,
          axis: widget.axis ?? Axis.horizontal,
          child: w,
        );
        break;
      case StyledToastAnimation.sizeFade:
        w = CustomSizeTransition(
          sizeFactor: sizeAnim,
          axisAlignment: 0.0,
          alignment: positionAlignment ?? Alignment.center,
          axis: widget.axis ?? Axis.horizontal,
          child: FadeTransition(
            opacity: fadeAnim,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.scale:
        w = ScaleTransition(
          scale: scaleAnim,
          alignment: widget.alignment ?? Alignment.center,
          child: w,
        );
        break;
      case StyledToastAnimation.fadeScale:
        w = FadeTransition(
          opacity: fadeAnim,
          child: ScaleTransition(
            scale: scaleAnim,
            alignment: widget.alignment ?? Alignment.center,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.rotate:
        w = RotationTransition(
          turns: rotateAnim,
          alignment: widget.alignment ?? FractionalOffset.center,
          child: w,
        );
        break;
      case StyledToastAnimation.fadeRotate:
        w = FadeTransition(
          opacity: fadeAnim,
          child: RotationTransition(
            turns: rotateAnim,
            alignment: widget.alignment ?? FractionalOffset.center,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.scaleRotate:
        w = ScaleTransition(
          scale: scaleAnim,
          alignment: widget.alignment ?? Alignment.center,
          child: RotationTransition(
            turns: rotateAnim,
            alignment: widget.alignment ?? FractionalOffset.center,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.none:
        w = Container(
          child: w,
        );
        break;
      default:
        w = FadeTransition(
          opacity: fadeAnim,
          child: w,
        );
        break;
    }
    return w;
  }

  Widget createReverseAnimWidget(Widget w) {
    if (widget.reverseAnimation != null && widget.animation != widget.reverseAnimation) {
      switch (widget.reverseAnimation) {
        case StyledToastAnimation.fade:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.slideToTop:
          w = SlideTransition(
            position: slideToTopAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.slideToTopFade:
          w = SlideTransition(
            position: slideToTopAnimReverse,
            child: FadeTransition(
              opacity: fadeAnimReverse,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.slideToBottom:
          w = SlideTransition(
            position: slideToBottomAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.slideToBottomFade:
          w = SlideTransition(
            position: slideToBottomAnimReverse,
            child: FadeTransition(
              opacity: fadeAnimReverse,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.slideToLeft:
          w = SlideTransition(
            position: slideToLeftAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.slideToLeftFade:
          w = SlideTransition(
            position: slideToLeftAnimReverse,
            child: FadeTransition(
              opacity: fadeAnimReverse,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.slideToRight:
          w = SlideTransition(
            position: slideToRightAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.slideToRightFade:
          w = SlideTransition(
            position: slideToRightAnimReverse,
            child: FadeTransition(
              opacity: fadeAnimReverse,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.size:
          w = CustomSizeTransition(
            alignment: positionAlignment ?? Alignment.center,
            axis: widget.axis ?? Axis.horizontal,
            sizeFactor: sizeAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.sizeFade:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: CustomSizeTransition(
              alignment: positionAlignment ?? Alignment.center,
              axis: widget.axis ?? Axis.horizontal,
              sizeFactor: sizeAnimReverse,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.scale:
          w = ScaleTransition(
            scale: scaleAnimReverse,
            alignment: widget.alignment ?? Alignment.center,
            child: w,
          );
          break;
        case StyledToastAnimation.fadeScale:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: ScaleTransition(
              scale: scaleAnimReverse,
              alignment: widget.alignment ?? Alignment.center,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.rotate:
          w = RotationTransition(
            turns: rotateAnimReverse,
            alignment: widget.alignment ?? FractionalOffset.center,
            child: w,
          );
          break;
        case StyledToastAnimation.fadeRotate:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: RotationTransition(
              turns: rotateAnimReverse,
              alignment: widget.alignment ?? FractionalOffset.center,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.scaleRotate:
          w = ScaleTransition(
            scale: scaleAnimReverse,
            child: RotationTransition(
              turns: rotateAnimReverse,
              alignment: widget.alignment ?? FractionalOffset.center,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.none:
          break;
        default:
          break;
      }
    }
    return w;
  }

  void dismissToast() {
    if (!mounted) {
      return;
    }
    _toastTimer?.cancel();
    setState(() {
      opacity = 0.0;
    });
  }

  Future<void> dismissToastAnim({VoidCallback? onAnimationEnd}) async {
    if (!mounted) {
      return;
    }
    _toastTimer?.cancel();
    try {
      if (widget.animation != widget.reverseAnimation || widget.reverseAnimBuilder != null) {
        await _reverseAnimController.forward().orCancel;
      } else {
        await _animationController.reverse().orCancel;
      }
      onAnimationEnd?.call();
    } on TickerCanceled {
      onAnimationEnd?.call();
    }
  }

  @override
  void dispose() {
    _toastTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    _reverseAnimController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (mounted) setState(() {});
  }
}

class StyledToastTheme extends InheritedWidget {
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final EdgeInsets? textPadding;
  final TextStyle? textStyle;
  final ShapeBorder? shapeBorder;
  final Duration? duration;
  final Duration? animDuration;
  final StyledToastPosition? toastPositions;
  final Alignment? alignment;
  final Axis? axis;
  final Offset? startOffset;
  final Offset? endOffset;
  final Offset? reverseStartOffset;
  final Offset? reverseEndOffset;
  final StyledToastAnimation? toastAnimation;
  final StyledToastAnimation? reverseAnimation;
  final Curve? curve;
  final Curve? reverseCurve;
  final bool? dismissOtherOnShow;
  final VoidCallback? onDismiss;
  final bool? fullWidth;
  final bool? isHideKeyboard;
  final CustomAnimationBuilder? animationBuilder;
  final CustomAnimationBuilder? reverseAnimBuilder;
  final bool? isIgnoring;
  final OnInitStateCallback? onInitState;

  const StyledToastTheme({
    super.key,
    required super.child,
    this.textAlign,
    this.textDirection,
    this.borderRadius,
    this.backgroundColor,
    this.textPadding,
    this.textStyle,
    this.shapeBorder,
    this.duration,
    this.animDuration,
    this.toastPositions,
    this.alignment,
    this.axis,
    this.startOffset,
    this.endOffset,
    this.reverseStartOffset,
    this.reverseEndOffset,
    this.toastAnimation,
    this.reverseAnimation,
    this.curve,
    this.reverseCurve,
    this.dismissOtherOnShow,
    this.onDismiss,
    this.fullWidth,
    this.isHideKeyboard,
    this.animationBuilder,
    this.reverseAnimBuilder,
    this.isIgnoring,
    this.onInitState,
  });

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static StyledToastTheme of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<StyledToastTheme>()!;

  static StyledToastTheme? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<StyledToastTheme>();
}

void dismissAllToast({bool showAnim = false}) {
  ToastManager().dismissAll(showAnim: showAnim);
}

class ToastFuture {
  final OverlayEntry _entry;
  final VoidCallback? _onDismiss;
  final GlobalKey<StyledToastWidgetState> _containerKey;
  bool _isShow = true;
  Timer? _timer;

  OverlayEntry get entry => _entry;

  VoidCallback? get onDismiss => _onDismiss;

  bool get isShow => _isShow;

  GlobalKey get containerKey => _containerKey;

  ToastFuture.create(
    Duration duration,
    this._entry,
    this._onDismiss,
    this._containerKey,
  ) {
    if (duration != Duration.zero) {
      _timer = Timer(duration, () => dismiss());
    }
  }

  Future<void> dismiss({
    bool showAnim = false,
  }) async {
    if (!_isShow) {
      return;
    }

    _isShow = false;
    _timer?.cancel();
    _onDismiss?.call();
    ToastManager().removeFuture(this);
    if (showAnim) {
      await _containerKey.currentState?.dismissToastAnim();
    } else {
      _containerKey.currentState?.dismissToast();
    }
    _entry.remove();
  }
}

class ToastManager {
  ToastManager._();

  static ToastManager? _instance;

  factory ToastManager() {
    _instance ??= ToastManager._();
    return _instance!;
  }

  Set<ToastFuture> toastSet = {};

  void dismissAll({
    bool showAnim = false,
  }) {
    toastSet.toList().forEach((v) {
      v.dismiss(showAnim: showAnim);
    });
  }

  void removeFuture(ToastFuture future) {
    toastSet.remove(future);
  }

  void addFuture(ToastFuture future) {
    toastSet.add(future);
  }
}

class StyledToastPosition {
  final Alignment align;

  final double offset;

  const StyledToastPosition({this.align = Alignment.center, this.offset = 0.0});

  static const center = StyledToastPosition(align: Alignment.center, offset: 0.0);
  static const top = StyledToastPosition(align: Alignment.topCenter, offset: 10.0);
  static const bottom = StyledToastPosition(align: Alignment.bottomCenter, offset: 20.0);
  static const left = StyledToastPosition(align: Alignment.centerLeft, offset: 17.0);
  static const right = StyledToastPosition(align: Alignment.centerRight, offset: 17.0);
}

enum StyledToastShowType {
  dismissShowing,
  normal,
}

enum StyledToastAnimation {
  fade,
  slideFromTop,
  slideFromTopFade,
  slideFromBottom,
  slideFromBottomFade,
  slideFromLeft,
  slideFromLeftFade,
  slideFromRight,
  slideFromRightFade,
  slideToTop,
  slideToTopFade,
  slideToBottom,
  slideToBottomFade,
  slideToLeft,
  slideToLeftFade,
  slideToRight,
  slideToRightFade,
  scale,
  size,
  sizeFade,
  fadeScale,
  rotate,
  fadeRotate,
  scaleRotate,
  none,
}

class CustomSizeTransition extends AnimatedWidget {
  const CustomSizeTransition({
    Key? key,
    this.axis = Axis.vertical,
    this.alignment,
    required Animation<double> sizeFactor,
    this.axisAlignment = 0.0,
    this.child,
  }) : super(key: key, listenable: sizeFactor);

  final Axis axis;

  final AlignmentGeometry? alignment;

  Animation<double> get sizeFactor => listenable as Animation<double>;

  final double axisAlignment;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final alignmentDirect = axis == Axis.vertical ? AlignmentDirectional(-1.0, axisAlignment) : AlignmentDirectional(axisAlignment, -1.0);
    return ClipRect(
      child: Align(
        alignment: alignment ?? alignmentDirect,
        heightFactor: axis == Axis.vertical ? math.max(sizeFactor.value, 0.0) : null,
        widthFactor: axis == Axis.horizontal ? math.max(sizeFactor.value, 0.0) : null,
        child: child,
      ),
    );
  }
}
