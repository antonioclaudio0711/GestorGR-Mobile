import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobi_gr/app/modules/principal/presenter/pages/principal_page.dart';
import 'package:mobi_gr/utils/app_routes.dart';

class PrincipalModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      AppRoutes.initialRoute,
      child: (context) => const PrincipalPage(),
    );
  }
}
