import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrincipalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrincipalAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => SystemNavigator.pop(),
          child: const Text(
            'Sair',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
