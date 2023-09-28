import 'package:flutter/material.dart';
import 'package:mobi_gr/app/modules/principal/presenter/widgets/principal_app_bar.dart';
import 'package:mobi_gr/app/modules/principal/presenter/widgets/principal_drawer.dart';
import 'package:mobi_gr/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? idDescription = '';
  String? mobProduct = '';
  String? lastAccess = '';

  @override
  void initState() {
    super.initState();
    loadPreferences(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadPreferences(BuildContext context) async {
    SharedPreferences preferencesId = await SharedPreferences.getInstance();
    idDescription = preferencesId.getString('iddescricao');

    SharedPreferences preferencesProduct =
        await SharedPreferences.getInstance();
    mobProduct = preferencesProduct.getString('MOB_MPRO');

    SharedPreferences preferencesLastAccess =
        await SharedPreferences.getInstance();
    if (preferencesLastAccess.getString('ultimoacesso') == null) {
      Preferences.setString(
        'ultimoacesso',
        '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()} às ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}',
      );

      lastAccess =
          '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()} às ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}';
    } else {
      lastAccess = await Preferences.getString('ultimoacesso');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const PrincipalAppBar(),
      drawer: PrincipalDrawer(
        idDescription: idDescription!,
        lastAccess: lastAccess!,
        mobProduct: mobProduct!,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
        child: const Icon(Icons.menu), // Ícone do botão
      ),
    );
  }
}
