import 'dart:async';

import 'package:bravo_cliente/views/auth_or_home_page.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState() {
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AuthOrHomePage()),
            (route) => false);
      });
    });

    
      Timer(Duration(milliseconds: 250), (){
        setState(() {
          _isVisible = true;
        });
      });
      
    


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
            begin: const FractionalOffset(0, 0),
            end: const FractionalOffset(1.0, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(
          milliseconds: 1200,
        ),
        child: Center(
          child: Container(
            width: 130,
            height: 150,
            child: Center(
              child: ClipOval(
                child: Image.asset(
                      "lib/assets/imagens/logo.png",
                    width: 250,
                    height: 300,
                  ),
              ),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white70.withOpacity(1), 
                boxShadow: [
                  BoxShadow( 
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2.0,
                      offset: const Offset(5.0, 3.0),
                      spreadRadius: 2.0)
                ]),
          ),
        ),
      ),
    );
  }
}
