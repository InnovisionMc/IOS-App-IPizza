import 'package:flutter/material.dart';
import 'package:ipizza/cart_screen.dart';
import 'summary_screen.dart';
import 'model/products.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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

class _MyHomePageState extends State<MyHomePage> {
  List<Product> produtos = getMockProducts();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: ProductCategory.values.length,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.red,
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
                // Adicione aqui a função para abrir a tela de carrinho de compras
              },
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.red,
            indicatorColor: Colors.red,
            isScrollable: true,
            tabs: ProductCategory.values.map((category) {
              return Tab(text: category.categoryText);
            }).toList(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: TabBarView(
            children: ProductCategory.values.map((category) {
              List<Product> produtosCategoria =
                  produtos.where((p) => p.productCategory == category).toList();

              return ListView.builder(
                itemCount: produtosCategoria.length,
                itemBuilder: (context, index) {
                  if (index.isOdd) {
                    return const Divider(
                      thickness: 0.1,
                      color: Colors.grey,
                    );
                  }
                  Product product = produtosCategoria[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductListItem(
                      product: product,
                      onQuantityChanged: (newQuantity) {
                        setState(() {
                          product.quantity = newQuantity;
                        });
                      },
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        bottomNavigationBar: Container(
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
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 12),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'R\$ ${calculateTotal().toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SummaryScreen()),
                      );
                      // Adicione aqui a função para finalizar a compra
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.red,
                    minWidth: 150,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Ver carrinho',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }

  double calculateTotal() {
    double total = 0;
    for (Product product in produtos) {
      total += product.valor * product.quantity;
    }
    return total;
  }
}

class ProductListItem extends StatefulWidget {
  final Product product;
  final Function(int) onQuantityChanged;

  const ProductListItem(
      {required this.product, required this.onQuantityChanged});

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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pizza de Calabresa com Mussarela',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Mussarela, Calabresa e azeitona. * todas as nossas pizzas possuem gergelim na borda.',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),
                Text(
                  "R\$ 59,99",
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
              borderRadius: BorderRadius.circular(
                  8), // Define o raio de curvatura dos cantos
              image: DecorationImage(
                image: NetworkImage(
                  "https://t3.gstatic.com/licensed-image?q=tbn:ANd9GcQcHbxCjB7FY6Rttw1VZFdh0gIZmm4MLLjfmD0dhA11saxBKG_D49VVkmlvz3sE71-b",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
