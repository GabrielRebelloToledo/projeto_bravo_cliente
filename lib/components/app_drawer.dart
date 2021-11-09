
import 'package:bravo_cliente/models/auth.dart';
import 'package:bravo_cliente/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Seja Bem Vindo!',
              style: TextStyle(fontSize: 19),
            ),
            accountEmail: Text(''),
            currentAccountPicture: Image.asset(
              "lib/assets/imagens/logo.png",
              width: 600,
              height: 600,
            ),
          ),
           Divider(),
           ListTile(
            leading: Icon(Icons.list_alt_outlined),
            title: Text('Suas Reservas'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.home,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.assignment_ind_outlined),
            title: Text('Cadastra reserva'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.cadastroP,
              );
            },
          ),  
          /* Divider(), */
          /* ListTile(
            leading: Icon(Icons.paste),
            title: Text('Gerênciar Reservas'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.gerenciaList,
              );
            },
          ), */
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              Provider.of<Auth>(
                context,
                listen: false,
              ).logout();

              Navigator.of(context).pushReplacementNamed(
                Routes.splashScreen,
              );
            },
          ),
        ],
      ),
    );
  }
}
