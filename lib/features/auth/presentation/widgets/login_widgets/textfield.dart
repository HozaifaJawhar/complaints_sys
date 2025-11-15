import 'package:complaints_sys/app/responsive/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:complaints_sys/app/theme/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final Widget? prefixIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.prefixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText =
        widget.isPassword; // افتراضي: نص الحقل مخفي لو isPassword = true
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = UIHelpers.radiusSmall(context);

    return TextFormField(
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: _obscureText,
      textAlign: TextAlign.right,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: UIHelpers.normalTextSize(context),
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: UIHelpers.normalTextSize(context),
          color: AppColors.greyText,
        ),
        fillColor: AppColors.secondaryWhite,
        filled: true,

        // 👇 أيقونة العين تظهر بس إذا الحقل password
        prefixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.greyText,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.prefixIcon,
        contentPadding: EdgeInsets.symmetric(
          vertical: UIHelpers.spaceMedium(context),
          horizontal: UIHelpers.spaceMedium(context),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey2, width: 1.0),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
