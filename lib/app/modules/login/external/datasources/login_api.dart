import 'dart:async';
import 'dart:convert';
import 'package:mobi_gr/app/modules/login/domain/entities/api_response.dart';
import 'package:mobi_gr/app/modules/login/domain/entities/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {
  static Future<ApiResponse<User>> login({
    required String login,
    required String password,
    required String ip,
    required String port,
  }) async {
    var url = Uri.http(
      '$ip:$port',
      '/datasnap/rest/TServerMethods1/GETLogin/$login/$password',
    );

    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var user = User.fromJson(json);

        if (json['error'] == 'ok') {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString(
              'iddescricao', json['FUNCIONARIO_ID'] + '- ' + json['DESCRICAO']);
          sharedPreferences.setString('FUNCIONARIO_ID', json['FUNCIONARIO_ID']);
          sharedPreferences.setString('FUNCIONARIO_NOME', json['DESCRICAO']);
          sharedPreferences.setString('MOB_MPRO', json['MOB_MPRO']);

          return ApiResponse.ok(user);
        } else {
          return ApiResponse.error(json['error']);
        }
      } else {
        return ApiResponse.error(json['error']);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
