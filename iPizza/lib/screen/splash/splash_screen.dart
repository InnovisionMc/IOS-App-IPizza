import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home/products_screen.dart'; // Substitua pelo nome da sua tela inicial

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      // Navegue para a tela inicial após 3 segundos
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MyHomePage(title: '',)), // Substitua pelo nome da sua tela inicial
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Defina a cor de fundo vermelho para a splash screen
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.red,
    ));

    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Image.network('https://i.postimg.cc/C5TXM2Q6/logo.png', width: 200, height: 200,), // Substitua pelo caminho correto do seu logo
      ),
    );
  }
}
