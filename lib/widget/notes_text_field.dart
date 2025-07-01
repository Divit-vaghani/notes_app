import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final VoidCallback? toggleVisibility;
  final String? Function(String?)? validator;
  final bool passwordField;
  final Widget? prefixIcon;
  final bool readOnly;
  final int minLines;
  final int maxLines;
  final bool autoFocus;
  final int? maxLength;

  const NotesTextField({
    super.key,
    this.label,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.autoFocus = false,
    this.obscureText = false,
    this.toggleVisibility,
    this.validator,
    this.suffixIcon,
    this.passwordField = false,
    this.prefixIcon,
    this.readOnly = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label ?? '',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (label != null) const SizedBox(height: 8),
        TextFormField(
          maxLength: maxLength,
          autofocus: autoFocus,
          maxLines: maxLines,
          minLines: minLines,
          readOnly: readOnly,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.black54,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon ??
                (passwordField
                    ? IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: toggleVisibility,
                      )
                    : const SizedBox.shrink()),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
