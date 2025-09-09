import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  final int maxLines;
  final Color? backgroundColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? borderColor;
  final double borderRadius;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
    this.backgroundColor,
    this.labelColor,
    this.hintColor,
    this.borderColor,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: labelColor ?? const Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),

        // Text Field
        Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? const Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            validator: validator,
            enabled: enabled,
            maxLines: maxLines,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF374151),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 16,
                color: hintColor ?? const Color(0xFF9CA3AF),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}