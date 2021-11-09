
import 'package:bravo_cliente/components/app_drawer.dart';
import 'package:bravo_cliente/components/list_pessoas.dart';
import 'package:bravo_cliente/models/auth.dart';
import 'package:bravo_cliente/provider/pessoas.dart';
import 'package:bravo_cliente/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suas Reservas:'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.cadastroP,
              );
            },
            icon: const Icon(Icons.add),
          ),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.cadastroP);
        },
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<ProductList>(context, listen: false).loadProducts(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(
              child: Text('Ocorreu um erro!'),
            );
          } else {
            return Consumer<ProductList>(
              builder: (ctx, orders, child) => ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, i) => ListPessoa(
                        pessoa: orders.items[i],
                      )),
            );
          }
        },
      ),
    );
  }
}
