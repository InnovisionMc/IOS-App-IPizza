import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');

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
            if (widget.product.itensAdicionais.isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Theme(
                    data: ThemeData(dialogBackgroundColor: Colors.white),
                    child: AlertDialog(
                      title: Text('Confirmação'),
                      backgroundColor: Colors.white,
                      content: Text('Você deseja adicionar este item ao seu pedido?'),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0, right: 8.0),
                          child: TextButton(
                            child: Text('CANCELAR', style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              Navigator.of(context).pop(); // Fecha o alerta
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0, right: 18.0),
                          child: MaterialButton(
                            onPressed: () {
                              widget.onQuantityChanged(1, []);
                              Navigator.of(context).pop();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Colors.red,
                            minWidth: 150,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('ADICIONAR', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              showBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SelectedProductBottomSheet(
                    product: widget.product,
                    onTotalChanged: (totalValue) {},
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        selectedQuantities = newQuantity;
                      });
                      int totalQuantity = newQuantity.isNotEmpty ? newQuantity.reduce((a, b) => a + b) : 0;
                      widget.onQuantityChanged(totalQuantity, selectedQuantities);
                    },
                  );
                },
                backgroundColor: Colors.white,
              );
            }
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
                    Row(
                      children: [
                        if (widget.product.valorProdutoComDesconto != 0)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              " ${formatCurrency.format(widget.product.valorProdutoComDesconto)}",
                              style: TextStyle(
                                color: Colors.green[800],
                              ),
                            ),
                          ),
                        Text(
                          " ${formatCurrency.format(widget.product.valorProduto)}",
                          style: TextStyle(
                            color: widget.product.valorProdutoComDesconto != 0 ? Colors.grey : Colors.black,
                            decoration: widget.product.valorProdutoComDesconto != 0 ? TextDecoration.lineThrough : TextDecoration.none,
                            fontSize: widget.product.valorProdutoComDesconto != 0 ? 12: 15
                          ),
                        ),
                      ],
                    ),
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
            color: Colors.grey[200],
            height: 1,
            thickness: 1,
            indent: 8,
            endIndent: 8,
          ),
        ),
      ],
    );
  }
}
