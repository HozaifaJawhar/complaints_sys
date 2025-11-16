import 'package:flutter/material.dart';
import 'package:complaints_sys/core/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword && _isObscured,
      keyboardType: widget.keyboardType,
      style: const TextStyle(color: Colors.black87, fontFamily: 'Zain'),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: AppColors.primary500.withOpacity(0.7),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primary500.withOpacity(0.7),
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
    );
  }
}
