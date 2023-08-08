import 'estabelecimento.dart';

class ShoppingCart {
  List<CartItem> items = [];

  double get totalAmount {
    double total = 0;
    double totalItensAdicionais = 0;
    for (var item in items) {

      for (var adicional in item.selectedAdditions) {
        totalItensAdicionais += adicional.valorItemAdicional;
      }

      total += item.product.valorProduto;
    }
    return total + totalItensAdicionais;
  }

  void addItem(Produto product, int quantity, List<int> selectedQuantities) {
    List<ItemAdicional> selectedAdditions = [];

    if(product.itensAdicionais.isNotEmpty) {
      for (var i = 0; i < selectedQuantities.length; i++) {
        for (var j = 0; j < selectedQuantities[i]; j++) {
          selectedAdditions.add(product.itensAdicionais[i]);
        }
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
    double total = product.valorProduto * quantity;

    for (var addition in selectedAdditions) {
      total += addition.valorItemAdicional;
    }

    return total;
  }
}

