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

  final EasyButtonType type;

  /// Whether or not to animate the width of the button.
  ///
  /// If this is set to `false`, you might want to also check the `useEqualLoadingStateWidgetDimension` parameter and set it to `true`.
  final bool useWidthAnimation;

  /// `useEqualLoadingStateWidgetDimension` will be ignored if `useWidthAnimation` value is `true`.
  final bool useEqualLoadingStateWidgetDimension;
  final double width;
  final double height;

  /// The button's vertical & horizontal padding.
  ///
  /// This will be ignored when the `type` parameter value is set to `EasyButtonType.text`
  final double contentGap;
  final double borderRadius;

  /// Color for the button.
  ///
  /// For [`EasyButtonType.elevated`]: This will be the background color.
  ///
  /// For [`EasyButtonType.outlined`]: This will be the border color.
  ///
  /// For [`EasyButtonType.text`]: This will be the text color.
  final Color buttonColor;
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
    this.buttonColor = Colors.blueAccent,
    this.onPressed,
  }) : super(key: key);

  @override
  _EasyButtonState createState() => _EasyButtonState();
}

class _EasyButtonState extends State<EasyButton> with TickerProviderStateMixin {
  final GlobalKey _globalKey = GlobalKey();

  Animation? _anim;
  late AnimationController _animController;
  final Duration _duration = const Duration(
    milliseconds: 250,
  );
  EasyButtonState _state = EasyButtonState.idle;
  late double _width;
  late double _height;
  late double _borderRadius;

  @override
  dispose() {
    _animController.dispose();
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
      elevation: 0.0,
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
          child: _buildChildren(context),
          onPressed: _onButtonPressed(),
        );
      case EasyButtonType.outlined:
        return TextButton(
          style: outlinedButtonStyle,
          child: _buildChildren(context),
          onPressed: _onButtonPressed(),
        );
      case EasyButtonType.text:
        return TextButton(
          style: textButtonStyle,
          child: _buildChildren(context),
          onPressed: _onButtonPressed(),
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
        if (!widget.useWidthAnimation &&
            widget.useEqualLoadingStateWidgetDimension) {
          contentWidget = SizedBox.square(
            dimension: widget.height - (contentGap * 2),
            child: widget.loadingStateWidget,
          );
        } else {
          contentWidget = widget.loadingStateWidget;
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
    _anim = Tween(begin: 0.0, end: 1.0).animate(_animController)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - targetWidth) * _anim!.value);
          _borderRadius = initialBorderRadius -
              ((initialBorderRadius - targetBorderRadius) * _anim!.value);
        });
      })
      ..addStatusListener(stateListener);

    _animController.forward();
  }

  void _reverse() {
    _animController.reverse();
  }
}