import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/bar/bar_route.dart'
    as route;

const String barRouteName = '/barRoute';

typedef BarStatusCallback = void Function(BarStatus? status);
typedef OnTap = void Function(Bar<dynamic> bar);

/// A highly customizable widget so you can notify your user when you fell like he needs a beautiful explanation.
// ignore: must_be_immutable
class Bar<T> extends StatefulWidget {
  Bar({
    super.key,
    this.title,
    this.titleColor,
    this.titleSize,
    this.message,
    this.messageSize,
    this.messageColor,
    this.titleText,
    this.messageText,
    this.icon,
    this.shouldIconPulse = true,
    this.maxWidth,
    this.maxHeight,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
    this.textDirection = TextDirection.ltr,
    this.borderColor,
    this.borderWidth = 1,
    this.backgroundColor = const Color(0xFF303030),
    this.leftBarIndicatorColor,
    this.boxShadows,
    this.backgroundGradient,
    this.mainButton,
    this.onTap,
    this.duration,
    this.isDismissible = true,
    this.dismissDirection = BarDismissDirection.vertical,
    this.showProgressIndicator = false,
    this.progressIndicatorController,
    this.progressIndicatorBackgroundColor,
    this.progressIndicatorValueColor,
    this.barPosition = BarPosition.bottom,
    this.positionOffset = 0,
    this.barStyle = BarStyle.floating,
    this.forwardAnimationCurve = Curves.easeOutCirc,
    this.reverseAnimationCurve = Curves.easeOutCirc,
    this.animationDuration = const Duration(seconds: 1),
    this.barBlur = 0,
    this.blockBackgroundInteraction = false,
    this.routeBlur,
    this.routeColor,
    this.userInputForm,
    this.endOffset,
    this.barRoute,
    this.onStatusChanged,
  }) {
    onStatusChanged = onStatusChanged ?? (status) {};
  }

  /// Use it to speed up or slow down the animation duration.
  final Duration animationDuration;

  /// Will be ignored if [backgroundGradient] is not null.
  final Color backgroundColor;

  /// Makes [backgroundColor] be ignored.
  final Gradient? backgroundGradient;

  /// Default is 0.0. If different than 0.0, blurs only Bar's background.
  /// To take effect, make sure your [backgroundColor] has some opacity.
  /// The greater the value, the greater the blur.
  final double barBlur;

  /// Bar can be based on [BarPosition.top] or on [BarPosition.bottom] of your screen.
  /// [BarPosition.bottom] is the default.
  final BarPosition barPosition;

  route.BarRoute<T?>? barRoute;

  /// Bar can be floating or be grounded to the edge of the screen.
  /// If grounded, I do not recommend using [margin] or [borderRadius]. [BarStyle.floating] is the default
  /// If grounded, I do not recommend using a [backgroundColor] with transparency or [barBlur]
  final BarStyle barStyle;

  /// Determines if user can interact with the screen behind it
  /// If this is false, [routeBlur] and [routeColor] will be ignored
  final bool blockBackgroundInteraction;

  // Adds a border to every side of Bar
  /// I do not recommend using it with [showProgressIndicator] or [leftBarIndicatorColor].
  final Color? borderColor;

  /// Adds a radius to corners specified of Bar. Best combined with [margin].
  /// I do not recommend using it with [showProgressIndicator] or [leftBarIndicatorColor].
  final BorderRadius? borderRadius;

  /// Changes the width of the border if [borderColor] is specified.
  final double borderWidth;

  /// [boxShadows] The shadows generated by Bar. Leave it null if you don't want a shadow.
  /// You can use more than one if you feel the need.
  /// Check (this example)[https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/shadows.dart]
  final List<BoxShadow>? boxShadows;

  /// [BarDismissDirection.vertical] by default.
  /// Can also be [BarDismissDirection.horizontal] in which case both left and right dismiss are allowed.
  final BarDismissDirection dismissDirection;

  /// How long until Bar will hide itself (be dismissed). To make it indefinite, leave it null.
  final Duration? duration;

  /// Offset to be added to the end Bar position.
  /// Intended to replace [margin] when you need items below Bar to be accessible
  final Offset? endOffset;

  /// The [Curve] animation used when show() is called. [Curves.easeOut] is default.
  final Curve forwardAnimationCurve;

  /// You can use any widget here, but I recommend [Icon] or [Image] as indication of what kind
  /// of message you are displaying. Other widgets may break the layout
  final Widget? icon;

  /// Determines if the user can swipe or click the overlay (if [routeBlur] > 0) to dismiss.
  /// It is recommended that you set [duration] != null if this is false.
  /// If the user swipes to dismiss or clicks the overlay, no value will be returned.
  final bool isDismissible;

  /// If not null, shows a left vertical bar to better indicate the humor of the notification.
  /// It is not possible to use it with a [Form] and I do not recommend using it with [LinearProgressIndicator]
  final Color? leftBarIndicatorColor;

  /// Use if you need an action from the user. [TextButton] is recommended here.
  final Widget? mainButton;

  /// Adds a custom margin to Bar.
  final EdgeInsets margin;

  /// Used to set Bar height.
  final double? maxHeight;

  /// Used to limit Bar width (usually on large screens).
  final double? maxWidth;

  /// The message displayed to the user.
  final String? message;

  /// Color message displayed to the user ? default is black.
  final Color? messageColor;

  /// The message text size displayed to the user.
  final double? messageSize;

  /// Replaces [message]. Although this accepts a [Widget], it is meant to receive [Text] or  [RichText].
  final Widget? messageText;

  /// A callback for you to listen to the different Bar status.
  BarStatusCallback? onStatusChanged;

  /// A callback that registers the user's click anywhere. An alternative to [mainButton].
  final OnTap? onTap;

  /// Adds a custom padding to Bar
  /// The default follows material design guide line
  final EdgeInsets padding;

  final double positionOffset;

  /// A [LinearProgressIndicator] configuration parameter.
  final Color? progressIndicatorBackgroundColor;

  /// An optional [AnimationController] when you want to control the progress of your [LinearProgressIndicator].
  /// You are responsible for controlling the progress
  final AnimationController? progressIndicatorController;

  /// A [LinearProgressIndicator] configuration parameter.
  final Animation<Color>? progressIndicatorValueColor;

  /// The [Curve] animation used when dismiss() is called. [Curves.fastOutSlowIn] is default.
  final Curve reverseAnimationCurve;

  /// Default is 0.0. If different than 0.0, creates a blurred
  /// overlay that prevents the user from interacting with the screen.
  /// The greater the value, the greater the blur.
  /// It does not take effect if [blockBackgroundInteraction] is false
  final double? routeBlur;

  /// Default is [Colors.transparent]. Only takes effect if [routeBlur] > 0.0.
  /// Make sure you use a color with transparency here e.g. Colors.grey[600].withOpacity(0.2).
  /// It does not take effect if [blockBackgroundInteraction] is false
  final Color? routeColor;

  /// An option to animate the icon (if present). Defaults to true.
  final bool shouldIconPulse;

  /// True if you want to show a [LinearProgressIndicator].
  /// If [progressIndicatorController] is null, an infinite progress indicator will be shown
  final bool showProgressIndicator;

  /// [TextDirection.ltr] by default
  /// added to support rtl languages
  final TextDirection textDirection;

  /// The title displayed to the user.
  final String? title;

  /// Color title displayed to the user ? default is black.
  final Color? titleColor;

  /// The title text size displayed to the user.
  final double? titleSize;

  /// Replaces [title]. Although this accepts a [Widget], it is meant to receive [Text] or [RichText].
  final Widget? titleText;

  /// A [TextFormField] in case you want a simple user input. Every other widget is ignored if this is not null.
  final Form? userInputForm;

  @override
  State createState() => _BarState<T?>();

  /// Show the bar. Kicks in [BarStatus.isAppearing] state followed by [BarStatus.showing].
  Future<T?> show(BuildContext context) async {
    barRoute = route.showBar<T>(
      bar: this,
    ) as route.BarRoute<T?>;

    return Navigator.of(context).push(barRoute! as Route<T>);
  }

  /// Dismisses the bar causing is to return a future containing [result].
  /// When this future finishes, it is guaranteed that Bar was dismissed.
  Future<T?> dismiss([T? result]) async {
    // If route was never initialized, do nothing.
    if (barRoute == null) {
      return null;
    }

    if (barRoute!.isCurrent) {
      barRoute!.navigator!.pop(result);

      return barRoute!.completed;
    } else if (barRoute!.isActive) {
      // removeRoute is called every time you dismiss a Bar that is not the top route.
      // It will not animate back and listeners will not detect BarStatus.isHiding or BarStatus.dismissed
      // To avoid this, always make sure that Bar is the top route when it is being dismissed
      barRoute!.navigator!.removeRoute(barRoute!);
    }

    return null;
  }

  /// Checks if the bar is visible.
  bool isShowing() {
    if (barRoute == null) {
      return false;
    }

    return barRoute!.currentStatus == BarStatus.showing;
  }

  /// Checks if the bar is dismissed.
  bool isDismissed() {
    if (barRoute == null) {
      return false;
    }

    return barRoute!.currentStatus == BarStatus.dismissed;
  }

  bool isAppearing() {
    if (barRoute == null) {
      return false;
    }

    return barRoute!.currentStatus == BarStatus.isAppearing;
  }

  bool isHiding() {
    if (barRoute == null) {
      return false;
    }

    return barRoute!.currentStatus == BarStatus.isHiding;
  }
}

class _BarState<K extends Object?> extends State<Bar<K>>
    with TickerProviderStateMixin {
  BarStatus? currentStatus;

  GlobalKey? _backgroundBoxKey;
  late Completer<Size> _boxHeightCompleter;
  final Widget _emptyWidget = const SizedBox();
  late Animation<double> _fadeAnimation;
  AnimationController? _fadeController;
  final double _finalOpacity = 0.4;
  late FocusAttachment _focusAttachment;
  FocusScopeNode? _focusNode;
  final double _initialOpacity = 1;
  late bool _isTitlePresent;
  late double _messageTopMargin;
  CurvedAnimation? _progressAnimation;
  final Duration _pulseAnimationDuration = const Duration(seconds: 1);

  @override
  void dispose() {
    _fadeController?.dispose();
    widget.progressIndicatorController?.dispose();

    _focusAttachment.detach();
    _focusNode!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _backgroundBoxKey = GlobalKey();
    _boxHeightCompleter = Completer<Size>();

    assert(
      widget.userInputForm != null ||
          ((widget.message != null && widget.message!.isNotEmpty) ||
              widget.messageText != null),
      'A message is mandatory if you are not using userInputForm. Set either a message or messageText',
    );

    _isTitlePresent = widget.title != null || widget.titleText != null;
    _messageTopMargin = _isTitlePresent ? 6.0 : widget.padding.top;

    _configureLeftBarFuture();
    _configureProgressIndicatorAnimation();

    if (widget.icon != null && widget.shouldIconPulse) {
      _configurePulseAnimation();
      _fadeController?.forward();
    }

    _focusNode = FocusScopeNode();
    _focusAttachment = _focusNode!.attach(context);
  }

  void _configureLeftBarFuture() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        final keyContext = _backgroundBoxKey!.currentContext;

        if (keyContext != null) {
          final box = keyContext.findRenderObject()! as RenderBox;
          _boxHeightCompleter.complete(box.size);
        }
      },
    );
  }

  void _configureProgressIndicatorAnimation() {
    if (widget.showProgressIndicator &&
        widget.progressIndicatorController != null) {
      _progressAnimation = CurvedAnimation(
        curve: Curves.linear,
        parent: widget.progressIndicatorController!,
      );
    }
  }

  void _configurePulseAnimation() {
    _fadeController =
        AnimationController(vsync: this, duration: _pulseAnimationDuration);
    _fadeAnimation = Tween(begin: _initialOpacity, end: _finalOpacity).animate(
      CurvedAnimation(
        parent: _fadeController!,
        curve: Curves.linear,
      ),
    );

    _fadeController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeController!.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _fadeController!.forward();
      }
    });

    _fadeController!.forward();
  }

  Widget _getBar() {
    Widget bar;

    bar = widget.userInputForm != null ? _generateInputBar() : _generateBar();

    return Stack(
      children: [
        FutureBuilder(
          future: _boxHeightCompleter.future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (widget.barBlur == 0) {
                return _emptyWidget;
              }

              return ClipRRect(
                borderRadius: widget.borderRadius,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: widget.barBlur,
                    sigmaY: widget.barBlur,
                  ),
                  child: Container(
                    height: snapshot.data!.height,
                    width: snapshot.data!.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: widget.borderRadius,
                    ),
                  ),
                ),
              );
            }

            return _emptyWidget;
          },
        ),
        bar,
      ],
    );
  }

  Widget _generateInputBar() {
    return Container(
      key: _backgroundBoxKey,
      constraints: widget.maxWidth != null
          ? BoxConstraints(maxWidth: widget.maxWidth!)
          : null,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        boxShadow: widget.boxShadows,
        borderRadius: widget.borderRadius,
        border: widget.borderColor != null
            ? Border.fromBorderSide(
                BorderSide(
                  color: widget.borderColor!,
                  width: widget.borderWidth,
                ),
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 16),
        child: FocusScope(
          node: _focusNode,
          autofocus: true,
          child: widget.userInputForm!,
        ),
      ),
    );
  }

  Widget _generateBar() {
    return Container(
      key: _backgroundBoxKey,
      constraints: widget.maxWidth != null
          ? BoxConstraints(maxWidth: widget.maxWidth!)
          : null,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        boxShadow: widget.boxShadows,
        borderRadius: widget.borderRadius,
        border: widget.borderColor != null
            ? Border.fromBorderSide(
                BorderSide(
                  color: widget.borderColor!,
                  width: widget.borderWidth,
                ),
              )
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: _getAppropriateRowLayout(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    if (widget.showProgressIndicator && _progressAnimation != null) {
      return AnimatedBuilder(
        animation: _progressAnimation!,
        builder: (_, __) {
          return LinearProgressIndicator(
            value: _progressAnimation!.value,
            backgroundColor: widget.progressIndicatorBackgroundColor,
            valueColor: widget.progressIndicatorValueColor,
          );
        },
      );
    }

    if (widget.showProgressIndicator) {
      return LinearProgressIndicator(
        backgroundColor: widget.progressIndicatorBackgroundColor,
        valueColor: widget.progressIndicatorValueColor,
      );
    }

    return _emptyWidget;
  }

  List<Widget> _getAppropriateRowLayout() {
    double buttonRightPadding;
    var iconPadding = 0.0;
    buttonRightPadding =
        widget.padding.right - 12 < 0 ? 4 : widget.padding.right - 12;

    if (widget.padding.left > 16.0) {
      iconPadding = widget.padding.left;
    }

    if (widget.icon == null && widget.mainButton == null) {
      return [
        _buildLeftBarIndicator(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (_isTitlePresent) ...{
                Padding(
                  padding: EdgeInsets.only(
                    top: widget.padding.top,
                    left: widget.padding.left,
                    right: widget.padding.right,
                  ),
                  child: _getTitleText(),
                ),
              } else ...{
                _emptyWidget,
              },
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: widget.padding.left,
                  right: widget.padding.right,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
      ];
    } else if (widget.icon != null && widget.mainButton == null) {
      return <Widget>[
        _buildLeftBarIndicator(),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            width: iconPadding + 42.0,
            height: widget.maxHeight,
          ),
          child: _getIcon(),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (_isTitlePresent) ...{
                Padding(
                  padding: EdgeInsets.only(
                    top: widget.padding.top,
                    left: 4,
                    right: widget.padding.left,
                  ),
                  child: _getTitleText(),
                ),
              } else ...{
                _emptyWidget,
              },
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: 4,
                  right: widget.padding.right,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
      ];
    } else if (widget.icon == null && widget.mainButton != null) {
      return <Widget>[
        _buildLeftBarIndicator(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (_isTitlePresent) ...{
                Padding(
                  padding: EdgeInsets.only(
                    top: widget.padding.top,
                    left: widget.padding.left,
                    right: widget.padding.right,
                  ),
                  child: _getTitleText(),
                ),
              } else ...{
                _emptyWidget,
              },
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: widget.padding.left,
                  right: 8,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: buttonRightPadding),
          child: _getMainActionButton(),
        ),
      ];
    } else {
      return <Widget>[
        _buildLeftBarIndicator(),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            width: iconPadding + 42.0,
            height: widget.maxHeight,
          ),
          child: _getIcon(),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (_isTitlePresent) ...{
                Padding(
                  padding: EdgeInsets.only(
                    top: widget.padding.top,
                    left: 4,
                    right: 8,
                  ),
                  child: _getTitleText(),
                ),
              } else ...{
                _emptyWidget,
              },
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: 4,
                  right: 8,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
        if (_getMainActionButton() != null) ...{
          Padding(
            padding: EdgeInsets.only(right: buttonRightPadding),
            child: _getMainActionButton(),
          ),
        } else ...{
          _emptyWidget,
        },
      ];
    }
  }

  Widget _buildLeftBarIndicator() {
    return widget.leftBarIndicatorColor != null
        ? FutureBuilder(
            future: _boxHeightCompleter.future,
            builder: (buildContext, snapshot) {
              return snapshot.hasData
                  ? Container(
                      width: 8,
                      height: snapshot.data!.height,
                      decoration: BoxDecoration(
                        borderRadius: widget.borderRadius == null
                            ? null
                            : widget.textDirection == TextDirection.ltr
                                ? BorderRadius.only(
                                    topLeft: widget.borderRadius!.topLeft,
                                    bottomLeft: widget.borderRadius!.bottomLeft,
                                  )
                                : BorderRadius.only(
                                    topRight: widget.borderRadius!.topRight,
                                    bottomRight:
                                        widget.borderRadius!.bottomRight,
                                  ),
                        color: widget.leftBarIndicatorColor,
                      ),
                    )
                  : _emptyWidget;
            },
          )
        : _emptyWidget;
  }

  Widget? _getIcon() {
    if (widget.icon != null && widget.icon is Icon && widget.shouldIconPulse) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: widget.icon,
      );
    } else if (widget.icon != null) {
      return widget.icon;
    } else {
      return _emptyWidget;
    }
  }

  Widget? _getTitleText() {
    return widget.titleText ??
        Text(
          widget.title ?? '',
          style: TextStyle(
            fontSize: widget.titleSize ?? 16.0,
            color: widget.titleColor ?? Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
  }

  Text _getDefaultNotificationText() {
    return Text(
      widget.message ?? '',
      maxLines: 8,
      style: TextStyle(
        fontSize: widget.messageSize ?? 14.0,
        color: widget.messageColor ?? Colors.white,
      ),
    );
  }

  Widget? _getMainActionButton() {
    return widget.mainButton;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 1,
      child: Material(
        color: widget.barStyle == BarStyle.floating
            ? Colors.transparent
            : widget.backgroundColor,
        child: SafeArea(
          minimum: widget.barPosition == BarPosition.bottom
              ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                )
              : EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
          // ? EdgeInsets.only(
          //     bottom: (MediaQuery.of(context).padding.bottom +
          //         widget.positionOffset))
          // : EdgeInsets.only(
          //     top: (MediaQuery.of(context).padding.top) +
          //         widget.positionOffset),
          bottom: widget.barPosition == BarPosition.bottom,
          top: widget.barPosition == BarPosition.top,
          left: false,
          right: false,
          child: _getBar(),
        ),
      ),
    );
  }
}

/// Indicates if bar is going to start at the [top] or at the [bottom].
enum BarPosition { top, bottom }

/// Indicates if bar will be attached to the edge of the screen or not.
enum BarStyle { floating, grounded }

/// Indicates the direction in which it is possible to dismiss
/// If vertical, dismiss up will be allowed if [BarPosition.top]
/// If vertical, dismiss down will be allowed if [BarPosition.bottom]
enum BarDismissDirection { horizontal, vertical }

/// Indicates the animation status
/// [BarStatus.showing] Bar has stopped and the user can see it
/// [BarStatus.dismissed] Bar has finished its mission and returned any pending values
/// [BarStatus.isAppearing] Bar is moving towards [BarStatus.showing]
/// [BarStatus.isHiding] Bar is moving towards [] [BarStatus.dismissed]
enum BarStatus { showing, dismissed, isAppearing, isHiding }
