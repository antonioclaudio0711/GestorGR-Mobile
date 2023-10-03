import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestorgr_mobile/app/modules/product/presenter/pages/product_page.dart';
import 'package:gestorgr_mobile/utils/app_routes.dart';

class ProductModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      AppRoutes.initialRoute,
      child: (context) => const ProductPage(),
    );
  }
}
