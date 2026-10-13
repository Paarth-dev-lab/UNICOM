import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary, ghost, outline, danger }
enum ButtonSize { sm, md, lg }

class CustomButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool fullWidth;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.fullWidth = false,
    this.padding,
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    // Determine heights
    double height = 48.0;
    switch (widget.size) {
      case ButtonSize.sm:
        height = 32.0;
        break;
      case ButtonSize.md:
        height = 48.0;
        break;
      case ButtonSize.lg:
        height = 56.0;
        break;
    }

    // Determine colors based on variant
    Color bgColor = widget.backgroundColor ?? Colors.blueAccent;
    Color txtColor = widget.textColor ?? Colors.white;
    Border? border;

    switch (widget.variant) {
      case ButtonVariant.primary:
        break; // Default above
      case ButtonVariant.secondary:
        bgColor = Colors.yellowAccent;
        txtColor = Colors.black;
        break;
      case ButtonVariant.ghost:
        bgColor = Colors.transparent;
        txtColor = Colors.white70;
        break;
      case ButtonVariant.outline:
        bgColor = Colors.transparent;
        border = Border.all(color: Colors.white24);
        break;
      case ButtonVariant.danger:
        bgColor = Colors.redAccent.withOpacity(0.1);
        txtColor = Colors.redAccent;
        break;
    }

    // If explicit colors provided, override
    if (widget.backgroundColor != null) bgColor = widget.backgroundColor!;
    if (widget.textColor != null) txtColor = widget.textColor!;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Opacity(
          opacity: widget.onPressed == null ? 0.5 : 1.0,
          child: Container(
            height: height,
            width: widget.fullWidth ? double.infinity : null,
            padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
              border: border,
              boxShadow: widget.variant == ButtonVariant.primary && widget.onPressed != null
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : null,
            ),
            alignment: Alignment.center,
            child: DefaultTextStyle(
              style: TextStyle(
                color: txtColor,
                fontSize: widget.size == ButtonSize.sm ? 12 : (widget.size == ButtonSize.lg ? 16 : 14),
                fontWeight: FontWeight.w600,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
