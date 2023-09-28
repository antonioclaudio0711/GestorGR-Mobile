import 'package:shared_preferences/shared_preferences.dart';

class User {
  User({
    required this.userId,
    required this.description,
    required this.mobInventory,
    required this.mobTicket,
    required this.mobMProduct,
    required this.supervisor,
    required this.blocked,
    required this.error,
  });

  final String userId;
  final String description;
  final String mobInventory;
  final String mobTicket;
  final String mobMProduct;
  final String supervisor;
  final String blocked;
  final String error;

  factory User.fromJson(Map json) => User(
        userId: json['FUNCIONARIO_ID'] ?? '',
        description: json['DESCRICAO'] ?? '',
        mobInventory: json['MOB_INVE'] ?? '',
        mobTicket: json['MOB_ETIQ'] ?? '',
        mobMProduct: json['MOB_MPROD'] ?? '',
        supervisor: json['SUPERVISOR'] ?? '',
        blocked: json['BLOQUEADO'] ?? '',
        error: json['error'] ?? '',
      );

  Future<void> save() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('nome', description);
  }

  static Future<String?> get() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? name = sharedPreferences.getString('nome');
    return name;
  }
}
