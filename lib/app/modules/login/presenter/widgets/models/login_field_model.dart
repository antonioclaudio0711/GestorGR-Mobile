import 'package:flutter/material.dart';

class LoginFieldModel {
  LoginFieldModel({
    this.labelText,
    this.hintText,
    required this.isPassword,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    this.onChanged,
    this.initialValue,
  });

  final String? labelText;
  final String? hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String?)? onFieldSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  final Function(String)? onChanged;
  final String? initialValue;
}
