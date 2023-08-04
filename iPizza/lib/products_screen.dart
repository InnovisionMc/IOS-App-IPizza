import 'package:flutter/material.dart';
import 'package:ipizza/cart_screen.dart';
import 'package:ipizza/model/estabelecimento.dart';
import 'package:ipizza/service/service.dart';
import 'summary_screen.dart';
import 'model/products.dart';
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

      // Loop through the unidades and add the cardapio of each unidade to the list
      for (Unidade unidade in unidades) {
        cardapio.addAll(unidade.cardapio);
      }

      print('Unidades: $unidades');
      print('Cardapio: $cardapio');

      // Do something with the cardapio list or other data
      // For example, you can update the state with the fetched data
      setState(() {
        produtos = cardapio;
      });
    } else {
      // Handle the case when the request fails
      // You can show an error message or take other actions
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
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.red,
            indicatorColor: Colors.red,
            isScrollable: true,
            tabs: groupedProducts.keys.map((category) {
              return Tab(text: category);
            }).toList(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: TabBarView(

            children: groupedProducts.keys.map((category) {
              List<Produto> products = groupedProducts[category]!;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Produto product = products[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductListItem(
                      product: product,
                      onQuantityChanged: (newQuantity) {
                        setState(() {
                          // product.quantity = newQuantity;
                        });
                      },
                    ),
                  );
                },
              );
            }).toList(),
          ),

        ),
      ),
    );
  }
}

class ProductListItem extends StatefulWidget {
  final Produto product;
  final Function(int) onQuantityChanged;

  const ProductListItem({required this.product, required this.onQuantityChanged});

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200.0,
                    color: Colors.white,
                    child: new Center(
                      child: new Text('This is a bottom sheet.'),
                    ),
                  );
                },
                isDismissible: true,
                showDragHandle: true,
                backgroundColor: Colors.white,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.tituloProduto,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.product.descricaoProduto,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),
                Text(
                  "R\$ ${widget.product.valorProduto.toStringAsFixed(2)}",
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            width: 110,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage('https://t3.gstatic.com/licensed-image?q=tbn:ANd9GcQcHbxCjB7FY6Rttw1VZFdh0gIZmm4MLLjfmD0dhA11saxBKG_D49VVkmlvz3sE71-b'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
