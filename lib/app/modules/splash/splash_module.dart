import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestorgr_mobile/app/modules/splash/presenter/pages/splash_page.dart';
import 'package:gestorgr_mobile/utils/app_routes.dart';

class SplashModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      AppRoutes.initialRoute,
      child: (context) => const SplashPage(),
    );
  }
}
