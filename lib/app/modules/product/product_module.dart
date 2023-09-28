import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobi_gr/app/modules/product/presenter/pages/product_page.dart';
import 'package:mobi_gr/utils/app_routes.dart';

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
