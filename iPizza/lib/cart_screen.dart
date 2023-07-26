import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Lista de itens genéricos do carrinho
  List<Item> cartItems = [
    Item(name: 'Item 1', quantity: 1),
    Item(name: 'Item 2', quantity: 2),
    Item(name: 'Item 3', quantity: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de Compras'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return _buildCartItem(cartItems[index]);
        },
      ),
    );
  }

  Widget _buildCartItem(Item item) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text('Quantidade: ${item.quantity}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              _decrementItemQuantity(item);
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _incrementItemQuantity(item);
            },
          ),
        ],
      ),
    );
  }

  void _incrementItemQuantity(Item item) {
    setState(() {
      item.quantity++;
    });
  }

  void _decrementItemQuantity(Item item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      }
    });
  }
}

class Item {
  final String name;
  int quantity;

  Item({required this.name, required this.quantity});
}