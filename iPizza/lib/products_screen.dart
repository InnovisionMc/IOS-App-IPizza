import 'package:flutter/material.dart';
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
      title: 'Flutter Demo',
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
          backgroundColor: Colors.red,
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                // Adicione aqui a função para abrir a tela de carrinho de compras
              },
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: ProductCategory.values.map((category) {
              return Tab(text: category.categoryText);
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: ProductCategory.values.map((category) {
            List<Product> produtosCategoria = produtos.where((p) => p.productCategory == category).toList();

            return ListView.builder(
              itemCount: produtosCategoria.length,
              itemBuilder: (context, index) {
                Product product = produtosCategoria[index];

                return ProductListItem(
                  product: product,
                  onQuantityChanged: (newQuantity) {
                    setState(() {
                      product.quantity = newQuantity;
                    });
                  },
                );
              },
            );
          }).toList(),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Valor Total: R\$ ${calculateTotal().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SummaryScreen()),
                  );
                  // Adicione aqui a função para finalizar a compra
                },
                child: Text('Finalizar Compra'),
              ),
            ],
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

  const ProductListItem({required this.product, required this.onQuantityChanged});

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network("https://t3.gstatic.com/licensed-image?q=tbn:ANd9GcQcHbxCjB7FY6Rttw1VZFdh0gIZmm4MLLjfmD0dhA11saxBKG_D49VVkmlvz3sE71-b", width: 48, height: 48),
      title: Text(widget.product.titulo),
      subtitle: Text(widget.product.descricao),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (widget.product.quantity > 1) {
                  widget.onQuantityChanged(widget.product.quantity - 1);
                }
              });
            },
          ),
          Text('${widget.product.quantity}'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                widget.onQuantityChanged(widget.product.quantity + 1);
              });
            },
          ),
          SizedBox(width: 16),
          Text('R\$ ${(widget.product.valor * widget.product.quantity).toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}