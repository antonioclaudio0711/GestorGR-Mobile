import 'package:flutter/material.dart';
import 'package:mobi_gr/utils/preferences.dart';
import 'package:mobi_gr/app/modules/login/presenter/widgets/login_field.dart';
import 'package:mobi_gr/app/modules/login/presenter/widgets/models/login_field_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController ipController = TextEditingController();
  TextEditingController portController = TextEditingController();

  @override
  void initState() {
    loadInitialInformations(context: context);
    super.initState();
  }

  String? validation(String? text) {
    if (text!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }

  Future<void> loadInitialInformations({required BuildContext context}) async {
    ipController.text = '127.0.0.1';
    portController.text = '211';

    if (await Preferences.getString('ip') == '') {
      Preferences.setString('ip', ipController.text);
    } else {
      ipController.text = await Preferences.getString('ip');
    }

    if (await Preferences.getString('port') == '') {
      Preferences.setString('port', portController.text);
    } else {
      portController.text = await Preferences.getString('port');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              LoginField(
                model: LoginFieldModel(
                  maxLength: 15,
                  isPassword: false,
                  labelText: 'IP Webservice',
                  hintText: 'Endereço IP WebService',
                  suffixIcon: const Icon(Icons.wifi),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: ipController,
                  onChanged: (text) => Preferences.setString('ip', text),
                  validator: validation,
                ),
              ),
              const SizedBox(height: 10),
              LoginField(
                model: LoginFieldModel(
                  maxLength: 5,
                  isPassword: false,
                  labelText: 'Porta',
                  hintText: 'Porta Webservice',
                  suffixIcon: const Icon(Icons.wifi),
                  keyboardType: TextInputType.number,
                  controller: portController,
                  onChanged: (text) => Preferences.setString('port', text),
                  validator: validation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
