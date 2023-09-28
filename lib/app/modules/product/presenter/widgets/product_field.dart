import 'package:flutter/material.dart';

class ProductField extends StatelessWidget {
  const ProductField({
    super.key,
    required this.searchProductController,
    required this.overscanOnPressed,
    required this.clearOnPressed,
    required this.submittedOnPressed,
  });

  final Function() overscanOnPressed;
  final Function() clearOnPressed;
  final Function(String) submittedOnPressed;
  final TextEditingController searchProductController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchProductController,
      decoration: InputDecoration(
        filled: true,
        suffixIcon: IconButton(
          onPressed: overscanOnPressed,
          icon: const Icon(Icons.settings_overscan),
        ),
        prefixIcon: IconButton(
          onPressed: clearOnPressed,
          icon: const Icon(Icons.clear),
        ),
        hintText: 'Buscar...',
      ),
      onSubmitted: submittedOnPressed,
    );
  }
}
