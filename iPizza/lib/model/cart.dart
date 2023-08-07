import 'estabelecimento.dart';

class ShoppingCart {
  List<CartItem> items = [];

  double get totalAmount {
    double total = 0;
    for (var item in items) {
      total += item.subtotal;
    }
    return total;
  }

  void addItem(Produto product, int quantity, List<int> selectedQuantities) {
    List<ItemAdicional> selectedAdditions = [];
    for (var i = 0; i < selectedQuantities.length; i++) {
      if (selectedQuantities[i] > 0) {
        selectedAdditions.add(product.itensAdicionais[i]);
      }
    }
    items.add(CartItem(product, quantity, selectedAdditions));
  }
}

class CartItem {
  final Produto product;
  final int quantity;
  final List<ItemAdicional> selectedAdditions;

  CartItem(this.product, this.quantity, this.selectedAdditions);

  double get subtotal {
    double total = product.valorProduto;

    for (var addition in selectedAdditions) {
      total += addition.valorItemAdicional;
    }

    return total * quantity;
  }
}
