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
        title: Image.network(
            'https://i.postimg.cc/C5TXM2Q6/logo.png',
            height: 70,
            width: 70,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.delete_forever),
              color: Colors.red,
              onPressed: () {
                //adicionar logica para limpar tela
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
                  TextButton(
                    onPressed: () {
                      // Lógica para ver mais
                    },
                    style: TextButton.styleFrom(primary: Colors.red),
                    child: Text('Ver mais', style: TextStyle(color: Colors.red)),
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
                      text: 'R\$ 00,00',
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
                    'Continuar',
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
          Container(
            width: 110,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  8),
              image: const DecorationImage(
                image: NetworkImage("https://t3.gstatic.com/licensed-image?q=tbn:ANd9GcQcHbxCjB7FY6Rttw1VZFdh0gIZmm4MLLjfmD0dhA11saxBKG_D49VVkmlvz3sE71-b"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Pizza de Calabresa',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('Valor: R\$ $itemPrice'),
                SizedBox(height: 8),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Fixa os ícones à direita
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
                Text('Total: R\$ ${itemCount * itemPrice}'),
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
    List<Map<String, dynamic>> suggestedItens  = [
      {'title': 'Guaraná Antártica', 'price': 5.0, 'description': 'Refrigerante'},
      {'title': 'Pizza de Chocolate', 'price': 20.0, 'description': 'Saborosa pizza de chocolate'},
      {'title': 'Batata Frita', 'price': 8.0, 'description': 'Porção de batata frita'},
    ];

    return Container(
      height: 150,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 100.0,
          enlargeCenterPage: true,
          autoPlay: false,
        ),
        items: suggestedItens.map((item) {
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