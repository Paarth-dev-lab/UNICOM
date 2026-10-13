import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final dynamic icon;
  final Widget? rightIcon;
  final String? placeholder;
  final String? hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool required;
  final ValueChanged<String>? onChanged;

  const CustomInput({
    super.key,
    this.icon,
    this.rightIcon,
    this.placeholder,
    this.hintText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.required = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHint = hintText ?? placeholder;
    
    Widget? effectiveIcon;
    if (icon is IconData) {
      effectiveIcon = Icon(icon, color: Colors.white.withOpacity(0.5));
    } else if (icon is Widget) {
      effectiveIcon = icon;
    }

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: effectiveHint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.4), width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            prefixIcon: effectiveIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: effectiveIcon,
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            suffixIcon: rightIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: rightIcon,
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
        ),
      ),
    );
  }
}
