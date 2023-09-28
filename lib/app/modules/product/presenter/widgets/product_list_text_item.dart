import 'package:flutter/material.dart';

class ProductListTextItem extends StatelessWidget {
  const ProductListTextItem({
    super.key,
    required this.textContent,
    this.textColor,
  });

  final String textContent;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        textContent,
        style: TextStyle(
          fontSize: 15,
          color: textColor,
        ),
      ),
    );
  }
}
