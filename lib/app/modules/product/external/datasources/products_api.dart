import 'dart:convert';

import 'package:mobi_gr/app/modules/product/domain/entities/products.dart';
import 'package:mobi_gr/utils/preferences.dart';
import 'package:http/http.dart' as http;

class ProductsApi {
  static Future<List<Products>> getProducts({
    required String key,
    required dynamic searchElement,
  }) async {
    final String userId = await Preferences.getString('FUNCIONARIO_ID');
    final String ip = await Preferences.getString('ip');
    final String port = await Preferences.getString('port');
    final Uri url = Uri.http(
      '$ip:$port',
      '/datasnap/rest/TServerMethods1/GETProdutos$searchElement/$userId/$key',
    );

    try {
      await Future.delayed(const Duration(milliseconds: 100));
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<Products> productsList = productsFromJson(response.body);
        return productsList;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<bool> updateProducts({
    required String productId,
    required String sellingValue,
    required String print,
  }) async {
    final String userId = await Preferences.getString('FUNCIONARIO_ID');
    final String ip = await Preferences.getString('ip');
    final String port = await Preferences.getString('port');
    final Uri url = Uri.http(
      '$ip:$port',
      '/datasnap/rest/TServerMethods1/UpdProdutos/$userId/$productId/$sellingValue/$print',
    );

    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final String jsonResponse = jsonDecode(response.body);
        if (jsonResponse == 'ok') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static List<Products> productsFromJson(String stringResponse) {
    return List<Products>.from(
      json.decode(stringResponse).map((x) => Products.fromJson(x)),
    );
  }

  static String productsToJson(List<Products> products) {
    return json.encode(
      List<dynamic>.from(
        products.map(
          (x) => x.productsToJson(),
        ),
      ),
    );
  }
}
