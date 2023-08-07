import 'package:flutter/material.dart';
import 'package:ipizza/screen/home/selected_product_bottomsheet.dart';
import '../../model/estabelecimento.dart';

class ProductListItem extends StatefulWidget {
  final Produto product;
  final Function(int, List<int>) onQuantityChanged;

  const ProductListItem({required this.product, required this.onQuantityChanged});

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  List<int> selectedQuantities = [];

  @override
  void initState() {
    super.initState();
    selectedQuantities = List.filled(widget.product.itensAdicionais.length, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SelectedProductBottomSheet(
                  product: widget.product,
                  onTotalChanged: (totalValue) {
                    // Implementar a ação desejada quando o total for alterado
                  },
                  onQuantityChanged: (newQuantity) {
                    setState(() {
                      selectedQuantities = newQuantity;
                    });
                    widget.onQuantityChanged(newQuantity.reduce((a, b) => a + b), selectedQuantities);
                  },
                );
              },
              backgroundColor: Colors.white,
            );
          },
          child: Row(
            children: [
              Expanded(
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Divider(
            color: Colors.grey[200], // Define a cor do Divider como cinza claro
            height: 1, // Define a altura do Divider (espessura)
            thickness: 1, // Define a espessura do Divider
            indent: 8, // Define o espaçamento à esquerda do Divider
            endIndent: 8, // Define o espaçamento à direita do Divider
          ),
        ),
      ],
    );
  }
}
