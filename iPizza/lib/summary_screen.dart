// tela2.dart

import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Revisão de Pedido'),
      ),
      body: Center(
        child: Text('Descrição Pedido'),
      ),
    );
  }
}
