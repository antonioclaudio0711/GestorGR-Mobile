import 'package:flutter/material.dart';

class LoginBottomNavigation extends StatelessWidget {
  const LoginBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      width: MediaQuery.of(context).size.width,
      child: const Text(
        'v1.0.2 © GR Tecnologia',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
