import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () => Modular.to.pop(),
          child: const Text('OK'),
        )
      ],
    );
  }
}
