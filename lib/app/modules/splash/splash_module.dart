import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobi_gr/app/modules/splash/presenter/pages/splash_page.dart';
import 'package:mobi_gr/utils/app_routes.dart';

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
