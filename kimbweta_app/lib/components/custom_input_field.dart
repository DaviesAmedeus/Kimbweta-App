import 'package:flutter/material.dart';
import 'package:kimbweta_app/constants/constants.dart';




class CustomInputField extends StatelessWidget {
  CustomInputField({super.key,
    this.textInputAction,
    // this.onSubmitted,
    this.controller,
    this.keyboardType,
    this.isPassword = false,
    this.hintText,
    this.validator
  });

  final bool isPassword;
  final TextInputAction? textInputAction;
  String? Function(String?)? validator;
  // final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,
      // onSubmitted: onSubmitted,
      cursorColor: kMainThemeAppColor,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            8,
          ),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: kMainThemeAppColor,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
      ),

    );
  }
}
