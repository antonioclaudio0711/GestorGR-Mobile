// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobi_gr/app/modules/login/domain/entities/api_response.dart';
import 'package:mobi_gr/app/modules/login/external/datasources/login_api.dart';
import 'package:mobi_gr/app/modules/login/presenter/widgets/login_bottom_navigation.dart';
import 'package:mobi_gr/app/modules/login/presenter/widgets/login_button.dart';
import 'package:mobi_gr/app/modules/login/presenter/widgets/login_field.dart';
import 'package:mobi_gr/app/modules/login/presenter/widgets/models/login_field_model.dart';
import 'package:mobi_gr/utils/widgets/custom_dialog.dart';
import 'package:mobi_gr/utils/app_routes.dart';
import 'package:mobi_gr/utils/asset_paths.dart';
import 'package:mobi_gr/utils/preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isPassword = true;
  bool showProgress = false;

  @override
  void initState() {
    super.initState();
    initialLoginState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initialLoginState() async {
    loginController.text = await Preferences.getString('login');
  }

  String? validation(String? text) {
    if (text!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }

  Future<void> onClickLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      setState(() => showProgress = true);

      Preferences.setString('login', loginController.text);

      String ip = await Preferences.getString('ip');
      String port = await Preferences.getString('port');
      if (ip == '' || port == '') {
        showDialog(
          context: context,
          builder: (context) => const CustomDialog(
            message:
                'Verifique na aba "Configurações" se o IP e a porta estão configurados corretamente!',
          ),
        );

        setState(() => showProgress = false);
      } else {
        log(ip: ip, port: port);
      }
    }
  }

  Future<void> log({required String ip, required String port}) async {
    try {
      ApiResponse login = await LoginApi.login(
        login: loginController.text,
        password: passwordController.text,
        ip: ip,
        port: port,
      );

      if (login.isOK!) {
        Modular.to.pushReplacementNamed(AppRoutes.principalModuleRoute);

        Preferences.setString(
          'ultimoacesso',
          '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()} às ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}',
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => CustomDialog(message: login.message!),
        );
        setState(() => showProgress = false);
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          message: 'Erro na requisição ao WebService: $ip:$port \n'
              'Verifique o endereço em configurações. \n Erro original: ${e.toString()}',
        ),
      );

      setState(() => showProgress = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 5.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                width: 170,
                height: 170,
                child: Image.asset(AssetPaths.logoGrTecnologia),
              ),
              LoginField(
                model: LoginFieldModel(
                  maxLength: 50,
                  isPassword: false,
                  labelText: 'Usuário/Login',
                  hintText: 'Seu usuário',
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(Icons.account_circle),
                  textInputAction: TextInputAction.next,
                  controller: loginController,
                  validator: validation,
                ),
              ),
              const SizedBox(height: 10),
              LoginField(
                model: LoginFieldModel(
                  maxLength: 50,
                  isPassword: isPassword,
                  labelText: 'Senha',
                  hintText: 'Sua senha',
                  keyboardType: TextInputType.text,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => isPassword = !isPassword);
                    },
                  ),
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  onFieldSubmitted: (_) => onClickLogin(),
                  validator: validation,
                ),
              ),
              LoginButton(
                onPressed: onClickLogin,
                showProgress: showProgress,
                text: 'Acessar',
              ),
              TextButton(
                onPressed: () => Modular.to.pushNamed(
                  AppRoutes.settingsModuleRoute,
                ),
                child: const Text(
                  'Configurações',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const LoginBottomNavigation(),
    );
  }
}
