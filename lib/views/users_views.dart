
import 'package:bravo_cliente/components/app_drawer.dart';
import 'package:bravo_cliente/components/list_users.dart';
import 'package:bravo_cliente/models/auth.dart';
import 'package:bravo_cliente/provider/user_register_provider.dart';
import 'package:bravo_cliente/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersViews extends StatefulWidget {


 UsersViews({Key? key, }) : super(key: key);

 

  @override
  _UsersViewsState createState() => _UsersViewsState();
}

class _UsersViewsState extends State<UsersViews> {

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
         title: const Text('Perfil do Entregador'),
        centerTitle: true,
        actions: <Widget>[
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
        future: Provider.of<UserRegisterProvider>(context, listen: false)
            .loadProducts(),  
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            /* print(snapshot.connectionState); */
            return Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.error != null) {
            return Center(
              child: Text('Ocorreu um erro!'),
            );
          } else {
            return Consumer<UserRegisterProvider>(
              builder: (ctx, orders, child) => ListView.builder(
                
                itemCount: orders.itemsCount,
                
                itemBuilder: (ctx, i) => ListUsers(users: orders.items[i],),
              ),
              
            );
            
            
          }
        },
      ),
    );
  }
}
