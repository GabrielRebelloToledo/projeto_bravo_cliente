
import 'package:bravo_cliente/components/app_drawer.dart';
import 'package:bravo_cliente/components/lis_gerencia.dart';
import 'package:bravo_cliente/models/auth.dart';
import 'package:bravo_cliente/provider/gerencia.dart';
import 'package:bravo_cliente/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageGerencia extends StatefulWidget {
  const PageGerencia({Key? key}) : super(key: key);

  @override
  _PageGerenciaState createState() => _PageGerenciaState();
}

class _PageGerenciaState extends State<PageGerencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas Solicitadas:'),
        centerTitle: true,
        actions: <Widget>[
          /* IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.cadastroP,
              );
            },
            icon: const Icon(Icons.add),
          ), */
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed(
                Routes.splashScreen,
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future:
            Provider.of<GerenciaList>(context, listen: false).loadProducts(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(
              child: Text('Ocorreu um erro!'),
            );
          } else {
            return Consumer<GerenciaList>(
              builder: (ctx, orders, child) => ListView.builder(
                
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, i) => ListGerencia(
                        pessoa: orders.items[i],
                      )),
            );
          }
        },
      ),
    );
  }
}
