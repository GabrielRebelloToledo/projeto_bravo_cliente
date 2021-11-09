import 'package:bravo_cliente/components/app_drawer.dart';
import 'package:bravo_cliente/models/auth.dart';
import 'package:bravo_cliente/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersNotRegister extends StatelessWidget {
  const UsersNotRegister({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
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
      body: Center(
                child: Column(
                  children: [
                    Padding(
                          padding: const EdgeInsets.all(30),
                          child: Text(
                            'Sr(a). Usuário(a) verifique se seu perfil existe, antes de realizar o cadastro, causando duplicidade!',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.cyanAccent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Clique no Botão abaixo para se Cadastrar', style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  Routes.cadastro
                                  );
                            },
                            child: Text('Cadastrar'),
                            style: ElevatedButton.styleFrom(primary: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}