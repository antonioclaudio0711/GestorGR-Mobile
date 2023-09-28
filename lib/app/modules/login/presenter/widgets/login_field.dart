import 'package:flutter/material.dart';
import 'package:mobi_gr/app/modules/login/presenter/widgets/models/login_field_model.dart';

class LoginField extends StatelessWidget {
  const LoginField({
    super.key,
    required this.model,
  });

  final LoginFieldModel model;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: model.maxLength,
      controller: model.controller,
      obscureText: model.isPassword,
      validator: model.validator,
      keyboardType: model.keyboardType,
      textInputAction: model.textInputAction,
      focusNode: model.focusNode,
      onChanged: model.onChanged,
      onFieldSubmitted: model.onFieldSubmitted,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        suffixIcon: model.suffixIcon,
        prefixIcon: model.prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: model.labelText,
        labelStyle: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
        hintText: model.hintText,
        hintStyle: const TextStyle(fontSize: 15),
      ),
    );
  }
}
