import 'dart:math';

class Product {
  final ProductCategory productCategory;
  final String titulo;
  final String descricao;
  final double valor;
  int quantity; // Adicionando a propriedade quantity

  Product({required this.productCategory, required this.titulo, required this.descricao, required this.valor, this.quantity = 1});
}


enum ProductCategory {
  pizzaDoce,
  pizzaSalgada,
  esfirraDoce,
  esfirraSalgada,
  bebidas,
  promocoes,
  maisPedidos
}

extension ProductCategoryExtension on ProductCategory {
  String get categoryText {
    switch (this) {
      case ProductCategory.pizzaDoce:
        return 'Pizzas Doces';
      case ProductCategory.pizzaSalgada:
        return 'Pizzas Salgadas';
      case ProductCategory.esfirraDoce:
        return 'Esfirras Doces';
      case ProductCategory.esfirraSalgada:
        return 'Esfirras Salgadas';
      case ProductCategory.bebidas:
        return 'Bebidas';
      case ProductCategory.promocoes:
        return 'Promoções';
      case ProductCategory.maisPedidos:
        return 'Mais Pedidos';
      default:
        return 'Outros';
    }
  }
}

List<Product> getMockProducts() {
  List<Product> mockProducts = [];
  for (int i = 1; i <= 10; i++) {
    String titulo = 'Produto $i';
    String descricao = 'Descrição do Produto $i';
    double valor = 10 + Random().nextInt(90).toDouble();
    ProductCategory category = ProductCategory.values[Random().nextInt(ProductCategory.values.length)];

    mockProducts.add(Product(productCategory: category, titulo: titulo, descricao: descricao, valor: valor, quantity: 0));
  }
  return mockProducts;
}


