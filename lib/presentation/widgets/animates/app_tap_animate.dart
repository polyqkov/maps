import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppTapAnimate extends StatefulWidget {
  const AppTapAnimate({
    Key? key,
    required this.child,
    this.pressedScale,
    this.onTap,
    this.isButton,
  }) : super(key: key);

  final Widget child;
  final double? pressedScale;
  final void Function()? onTap;
  final bool? isButton;

  @override
  State<AppTapAnimate> createState() => _AppTapAnimateState();
}

class _AppTapAnimateState extends State<AppTapAnimate>
    with SingleTickerProviderStateMixin {
  static const Duration kScaleDownDuration = Duration(milliseconds: 75);
  static const Duration kScaleUpDuration = Duration(milliseconds: 100);
  Tween<double>? _scaleTween;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleTween = Tween<double>(begin: 1.0, end: widget.pressedScale);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _scaleAnimation = _animationController
        .drive(CurveTween(curve: Curves.easeInOut))
        .drive(_scaleTween!);
    _updateTweenEnd();
  }

  @override
  void didUpdateWidget(AppTapAnimate old) {
    super.didUpdateWidget(old);
    _updateTweenEnd();
  }

  void _updateTweenEnd() {
    _scaleTween?.end = widget.pressedScale ?? 0.9;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _widgetHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_widgetHeldDown) {
      _widgetHeldDown = true;
      HapticFeedback.lightImpact();
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_widgetHeldDown) {
      _widgetHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_widgetHeldDown) {
      _widgetHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating == true) return;
    final bool wasHeldDown = _widgetHeldDown;
    final TickerFuture ticker = _widgetHeldDown
        ? _animationController.animateTo(1.0, duration: kScaleDownDuration)
        : _animationController.animateTo(0.0, duration: kScaleUpDuration);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _widgetHeldDown) _animate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.onTap != null;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? _handleTapDown : null,
      onTapUp: enabled ? _handleTapUp : null,
      onTapCancel: enabled ? _handleTapCancel : null,
      onTap: enabled ? widget.onTap : null,
      child: Semantics(
        button: widget.isButton ?? false,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}
