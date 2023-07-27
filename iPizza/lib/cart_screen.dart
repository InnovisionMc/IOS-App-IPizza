import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'summary_screen.dart';
import 'model/products.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  int itemCount = 1;
  double itemPrice = 52.0;
  double totalValue = 00.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: IconButton(
              icon: Icon(Icons.delete_forever),
              color: Colors.red,
              onPressed: () {
                // adicionar logica de busca
                // Adicione aqui a função para abrir a tela de carrinho de compras
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildItemWidget(),
              SizedBox(height: 20),
              Text('Peça também', style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              _buildGenericItemsCarousel(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Fidelidade', style: TextStyle(fontSize: 20)),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para ver mais
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text('Ver mais', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Valor total: R\$ $totalValue',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
            ],
          ),
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
              const Text.rich(
                TextSpan(
                  text: 'Total sem a entrega\n',
                  style: TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'R\$ 0.00',
                      style: TextStyle(
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


    );
  }

  Widget _buildItemWidget() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://t3.gstatic.com/licensed-image?q=tbn:ANd9GcQcHbxCjB7FY6Rttw1VZFdh0gIZmm4MLLjfmD0dhA11saxBKG_D49VVkmlvz3sE71-b', // Substitua pela URL da imagem real
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pizza de Calabresa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Valor do item: R\$ $itemPrice'),
                SizedBox(height: 8),
                Text('Quantidade:'),
                SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (itemCount > 1) itemCount--;
                          updateTotalValue();
                        });
                      },
                      icon: Icon(Icons.remove),
                      color: Colors.red,
                    ),
                    Text(itemCount.toString()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          itemCount++;
                          updateTotalValue();
                        });
                      },
                      icon: Icon(Icons.add),
                      color: Colors.red,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text('Valor total do item: R\$ ${itemCount * itemPrice}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateTotalValue() {
    setState(() {
      totalValue = itemCount * itemPrice;
    });
  }

  Widget _buildGenericItemsCarousel() {
    List<Map<String, dynamic>> genericItems = [
      {'title': 'Guaraná Antártica', 'price': 5.0, 'description': 'Refrigerante'},
      {'title': 'Pizza de Chocolate', 'price': 20.0, 'description': 'Saborosa pizza de chocolate'},
      {'title': 'Batata Frita', 'price': 8.0, 'description': 'Porção de batata frita'},
    ];

    return Container(
      height: 150,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 150.0,
          enlargeCenterPage: true,
          autoPlay: true,
        ),
        items: genericItems.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['title'],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item['description'],
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'R\$ ${item['price'].toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ShoppingCartScreen(),
  ));
}