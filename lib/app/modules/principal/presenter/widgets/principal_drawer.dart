import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobi_gr/utils/app_routes.dart';

class PrincipalDrawer extends StatelessWidget {
  const PrincipalDrawer({
    super.key,
    required this.idDescription,
    required this.lastAccess,
    required this.mobProduct,
  });

  final String idDescription;
  final String lastAccess;
  final String mobProduct;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(idDescription),
            accountEmail: Text(
              'Último acesso: $lastAccess',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Produtos'),
            subtitle: const Text('Manutenção de produtos'),
            enabled: mobProduct == 'S' ? true : false,
            onTap: () {
              if (mobProduct == 'S') {
                Modular.to.pushNamed(AppRoutes.productModuleRoute);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.assistant_direction),
            title: const Text('Configurações'),
            subtitle: const Text('Definir parâmetros'),
            onTap: () => Modular.to.pushNamed(AppRoutes.settingsModuleRoute),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            subtitle: const Text('Encerrar seção'),
            onTap: () => Modular.to.pushNamed(AppRoutes.loginModuleRoute),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            subtitle: const Text('Sair do app'),
            onTap: () => SystemNavigator.pop(),
          ),
        ],
      ),
    );
  }
}
