import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestorgr_mobile/app/modules/principal/presenter/pages/principal_page.dart';
import 'package:gestorgr_mobile/utils/app_routes.dart';

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
