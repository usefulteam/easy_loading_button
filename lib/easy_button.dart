part of easy_loading_button;

enum EasyButtonState {
  idle,
  loading,
}

enum EasyButtonType {
  elevated,
  outlined,
  text,
}

class EasyButton extends StatefulWidget {
  /// Content inside the button when the button state is idle.
  final Widget idleStateWidget;

  /// Content inside the button when the button state is loading.
  final Widget loadingStateWidget;

  /// The button type.
  final EasyButtonType type;

  /// Whether or not to animate the width of the button. Default is `true`.
  ///
  /// If this is set to `false`, you might want to set the `useEqualLoadingStateWidgetDimension` parameter to `true`.
  final bool useWidthAnimation;

  /// Whether or not to force the `loadingStateWidget` to have equal dimension.
  ///
  /// This is useful when you are using `CircularProgressIndicator` as the `loadingStateWidget`.
  ///
  /// This parameter might also be useful when you set the `useWidthAnimation` parameter to `true` combined with `CircularProgressIndicator` as the value for `loadingStateWidget`.
  final bool useEqualLoadingStateWidgetDimension;

  /// The button width.
  final double width;

  /// The button height.
  final double height;

  /// The gap between button and it's content.
  ///
  /// This will be ignored when the `type` parameter value is set to `EasyButtonType.text`
  final double contentGap;

  /// The visual border radius of the button.
  final double borderRadius;

  /// The elevation of the button.
  ///
  /// This will only be applied when the `type` parameter value is `EasyButtonType.elevated`
  final double elevation;

  /// Color for the button.
  ///
  /// For [`EasyButtonType.elevated`]: This will be the background color.
  ///
  /// For [`EasyButtonType.outlined`]: This will be the border color.
  ///
  /// For [`EasyButtonType.text`]: This will be the text color.
  final Color buttonColor;

  /// Function to run when button is pressed.
  final Function? onPressed;

  const EasyButton({
    Key? key,
    required this.idleStateWidget,
    required this.loadingStateWidget,
    this.type = EasyButtonType.elevated,
    this.useWidthAnimation = true,
    this.useEqualLoadingStateWidgetDimension = true,
    this.width = double.infinity,
    this.height = 40.0,
    this.contentGap = 0.0,
    this.borderRadius = 0.0,
    this.elevation = 0.0,
    this.buttonColor = Colors.blueAccent,
    this.onPressed,
  }) : super(key: key);

  @override
  State createState() => _EasyButtonState();
}

class _EasyButtonState extends State<EasyButton> with TickerProviderStateMixin {
  final GlobalKey _globalKey = GlobalKey();

  Animation? _anim;
  AnimationController? _animController;
  final Duration _duration = const Duration(
    milliseconds: 250,
  );
  EasyButtonState _state = EasyButtonState.idle;
  late double _width;
  late double _height;
  late double _borderRadius;

  @override
  dispose() {
    if (_animController != null) {
      _animController!.dispose();
    }

    super.dispose();
  }

  @override
  void deactivate() {
    _reset();
    super.deactivate();
  }

  @override
  void initState() {
    _reset();
    super.initState();
  }

  void _reset() {
    _state = EasyButtonState.idle;
    _width = widget.width;
    _height = widget.height;
    _borderRadius = widget.borderRadius;
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: SizedBox(
        key: _globalKey,
        height: _height,
        width: _width,
        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    var padding = EdgeInsets.all(
      widget.contentGap,
    );
    var buttonColor = widget.buttonColor;
    var shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
    );

    final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      padding: padding,
      primary: buttonColor,
      elevation: widget.elevation,
      shape: shape,
    );

    final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
      padding: padding,
      shape: shape,
      side: BorderSide(
        color: buttonColor,
      ),
    );

    final ButtonStyle textButtonStyle = TextButton.styleFrom(
      padding: padding,
    );

    switch (widget.type) {
      case EasyButtonType.elevated:
        return ElevatedButton(
          style: elevatedButtonStyle,
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
      case EasyButtonType.outlined:
        return TextButton(
          style: outlinedButtonStyle,
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
      case EasyButtonType.text:
        return TextButton(
          style: textButtonStyle,
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
    }
  }

  Widget _buildChildren(BuildContext context) {
    double contentGap =
        widget.type == EasyButtonType.text ? 0.0 : widget.contentGap;
    Widget contentWidget;

    switch (_state) {
      case EasyButtonState.idle:
        contentWidget = widget.idleStateWidget;

        break;
      case EasyButtonState.loading:
        contentWidget = widget.loadingStateWidget;

        if (widget.useEqualLoadingStateWidgetDimension) {
          contentWidget = SizedBox.square(
            dimension: widget.height - (contentGap * 2),
            child: widget.loadingStateWidget,
          );
        }

        break;
    }

    return contentWidget;
  }

  VoidCallback _onButtonPressed() {
    if (widget.onPressed == null) {
      return () {};
    }

    return _manageLoadingState;
  }

  Future _manageLoadingState() async {
    if (_state != EasyButtonState.idle) {
      return;
    }

    // The result of widget.onPressed() will be called as VoidCallback after button status is back to default.
    dynamic onIdle;

    if (widget.useWidthAnimation) {
      _toProcessing();
      _forward((status) {
        if (status == AnimationStatus.dismissed) {
          _toDefault();
          if (onIdle != null &&
              (onIdle is VoidCallback || onIdle is FormFieldValidator)) {
            onIdle();
          }
        }
      });
      onIdle = await widget.onPressed!();
      _reverse();
    } else {
      _toProcessing();
      onIdle = await widget.onPressed!();
      _toDefault();
      if (onIdle != null &&
          (onIdle is VoidCallback || onIdle is FormFieldValidator)) {
        onIdle();
      }
    }
  }

  void _toProcessing() {
    setState(() {
      _state = EasyButtonState.loading;
    });
  }

  void _toDefault() {
    if (mounted) {
      setState(() {
        _state = EasyButtonState.idle;
      });
    } else {
      _state = EasyButtonState.idle;
    }
  }

  void _forward(AnimationStatusListener stateListener) {
    double initialWidth = _globalKey.currentContext!.size!.width;
    double initialBorderRadius = widget.borderRadius;
    double targetWidth = _height;
    double targetBorderRadius = _height / 2;

    _animController = AnimationController(duration: _duration, vsync: this);
    _anim = Tween(begin: 0.0, end: 1.0).animate(_animController!)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - targetWidth) * _anim!.value);
          _borderRadius = initialBorderRadius -
              ((initialBorderRadius - targetBorderRadius) * _anim!.value);
        });
      })
      ..addStatusListener(stateListener);

    _animController!.forward();
  }

  void _reverse() {
    _animController!.reverse();
  }
}
