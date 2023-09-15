import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'summary_screen.dart';
import 'model/products.dart';

import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<CartItem> cartItems = []; // Suponho que você tenha uma lista de itens no carrinho

  @override
  Widget build(BuildContext context) {
    double totalValue = 0;

    for (CartItem item in cartItems) {
      totalValue += item.quantity * item.price;
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          'https://i.postimg.cc/C5TXM2Q6/logo.png',
          height: 70,
          width: 70,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                // Adicione aqui a lógica para limpar o carrinho
                setState(() {
                  cartItems.clear();
                });
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          CartItem cartItem = cartItems[index];
          return _buildItemWidget(cartItem);
        },
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
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'R\$ ${totalValue.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  // Adicione aqui a função para finalizar a compra
                  // Normalmente, você abriria uma tela de resumo ou checkout aqui.
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

  Widget _buildItemWidget(CartItem cartItem) {
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
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(cartItem.productImageURL),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  cartItem.productName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('Valor: R\$ ${cartItem.price.toStringAsFixed(2)}'),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (cartItem.quantity > 1) cartItem.quantity--;
                        });
                      },
                      icon: Icon(Icons.remove),
                      color: Colors.red,
                    ),
                    Text(cartItem.quantity.toString()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          cartItem.quantity++;
                        });
                      },
                      icon: Icon(Icons.add),
                      color: Colors.red,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text('Total: R\$ ${(cartItem.quantity * cartItem.price).toStringAsFixed(2)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String productName;
  final double price;
  late final int quantity;
  final String productImageURL;

  CartItem({
    required this.productName,
    required this.price,
    required this.quantity,
    required this.productImageURL,
  });
}