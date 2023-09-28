import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobi_gr/app/modules/login/login_module.dart';
import 'package:mobi_gr/app/modules/principal/principal_module.dart';
import 'package:mobi_gr/app/modules/product/product_module.dart';
import 'package:mobi_gr/app/modules/settings/settings_module.dart';
import 'package:mobi_gr/app/modules/splash/splash_module.dart';
import 'package:mobi_gr/utils/app_routes.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module(
      AppRoutes.initialRoute,
      module: SplashModule(),
    );

    r.module(
      AppRoutes.loginModuleRoute,
      module: LoginModule(),
    );

    r.module(
      AppRoutes.settingsModuleRoute,
      module: SettingsModule(),
    );

    r.module(
      AppRoutes.principalModuleRoute,
      module: PrincipalModule(),
    );

    r.module(
      AppRoutes.productModuleRoute,
      module: ProductModule(),
    );
  }
}
