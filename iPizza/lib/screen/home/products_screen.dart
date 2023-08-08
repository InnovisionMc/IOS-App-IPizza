import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ipizza/cart_screen.dart';
import 'package:ipizza/model/estabelecimento.dart';
import 'package:ipizza/screen/home/product_item.dart';
import 'package:ipizza/service/service.dart';
import '../../model/cart.dart';
import '../../summary_screen.dart';
import '../../model/products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iPizza',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Homes Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Produto> produtos = [];
  ShoppingCart shoppingCart = ShoppingCart();
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');

  @override
  void initState() {
    super.initState();
    fetchEstabelecimentoInfo();
  }

  Future<void> fetchEstabelecimentoInfo() async {
    Response? response = await getEstabelecimentoInfoApi();
    if (response != null) {
      Data data = response.data;
      List<Unidade> unidades = data.listaUnidades;
      List<Produto> cardapio = [];
      for (Unidade unidade in unidades) {
        cardapio.addAll(unidade.cardapio);
      }
      setState(() {
        produtos = cardapio;
      });
    } else {
      print('Falha ao obter dados da API.');
    }
  }

  Map<String, List<Produto>> groupProductsByCategory(List<Produto> products) {
    Map<String, List<Produto>> groupedProducts = {};
    for (Produto product in products) {
      if (groupedProducts.containsKey(product.categoriaProduto)) {
        groupedProducts[product.categoriaProduto]!.add(product);
      } else {
        groupedProducts[product.categoriaProduto] = [product];
      }
    }
    return groupedProducts;
  }

  double getBottomPadding() {
    if (shoppingCart.totalAmount > 0) {
      return 70.0; // Ajuste conforme necessário.
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Produto>> groupedProducts = groupProductsByCategory(produtos);

    return DefaultTabController(
      length: groupedProducts.keys.length,
      child: Scaffold(
        appBar: AppBar(
          title: Image.network(
            'https://i.postimg.cc/C5TXM2Q6/logo.png',
            height: 70,
            width: 70,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.red,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
                );
              },
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.red,
            indicatorColor: Colors.red,
            isScrollable: true,
            tabs: groupedProducts.keys.map((category) => Tab(text: category)).toList(),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: groupedProducts.keys.map((category) {
                List<Produto> products = groupedProducts[category]!;
                return Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: getBottomPadding()),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      Produto product = products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductListItem(
                          product: product,
                          onQuantityChanged: (newQuantity, selectedQuantities) {
                            setState(() {
                              shoppingCart.addItem(product, newQuantity, selectedQuantities);
                            });
                          },
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
            if (shoppingCart.totalAmount > 0)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 15.0,
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32, left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Total sem a entrega\n',
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                            children: [
                              TextSpan(
                                text: '${formatCurrency.format(shoppingCart.totalAmount)}',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.red,
                          minWidth: 150,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Ver carrinho', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
