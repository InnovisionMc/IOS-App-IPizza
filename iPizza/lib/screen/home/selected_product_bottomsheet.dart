import 'package:flutter/material.dart';
import '../../model/estabelecimento.dart';
import 'package:intl/intl.dart';

class SelectedProductBottomSheet extends StatefulWidget {
  final Produto product;
  final Function(List<int>) onQuantityChanged;
  final Function(double) onTotalChanged;

  const SelectedProductBottomSheet({
    Key? key,
    required this.product,
    required this.onQuantityChanged,
    required this.onTotalChanged,
  }) : super(key: key);

  @override
  State<SelectedProductBottomSheet> createState() =>
      _SelectedProductBottomSheetState();
}

class _SelectedProductBottomSheetState
    extends State<SelectedProductBottomSheet> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');
  List<int> selectedQuantities = [];

  @override
  void initState() {
    super.initState();
    selectedQuantities =
        List.filled(widget.product.itensAdicionais.length, 0);
  }

  double get totalValue {
    double total = widget.product.valorProduto;
    double totalItensAdicionais = 0.0;

    if(widget.product.itensAdicionais.isNotEmpty) {
      for (var i = 0; i < widget.product.itensAdicionais.length; i++) {
        totalItensAdicionais +=
            widget.product.itensAdicionais[i].valorItemAdicional *
                selectedQuantities[i];
      }
    }

    return total + totalItensAdicionais;
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: AnimatedContainer(
        height: MediaQuery.of(context).size.height * 0.9,
        duration: Duration(milliseconds: 200),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                child: Text(
                  widget.product.tituloProduto,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Container(
                    width: 110, // largura fixa
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://t3.gstatic.com/licensed-image?q=tbn:ANd9GcQcHbxCjB7FY6Rttw1VZFdh0gIZmm4MLLjfmD0dhA11saxBKG_D49VVkmlvz3sE71-b',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.descricaoProduto,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          formatCurrency.format(widget.product.valorProduto),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Itens adicionais:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.product.itensAdicionais.length,
                itemBuilder: (context, index) {
                  var item = widget.product.itensAdicionais[index];
                  return ListTile(
                    title: Text(
                      item.tituloItemAdicional,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.product.itensAdicionais[index].descricaoItemAdicional),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            formatCurrency.format(item.valorItemAdicional),
                          ),
                        ),
                      ],
                    ),
                    trailing: Container(
                      color: Colors.transparent,
                      child: Card(
                        color: Colors.red,
                        elevation: 4.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (selectedQuantities[index] > 0)
                              IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (selectedQuantities[index] > 0) {
                                      selectedQuantities[index]--;
                                    }
                                  });
                                  widget.onTotalChanged(totalValue);
                                },
                              ),
                            if (selectedQuantities[index] > 0)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  selectedQuantities[index].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  selectedQuantities[index]++;
                                });
                                widget.onTotalChanged(totalValue);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Material(
              elevation: 20,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, bottom: 12.0),
                        child: Text(
                          'Adicionar ${formatCurrency.format(totalValue)}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        widget.onQuantityChanged(selectedQuantities);
                        // Adicionar o produto ao carrinho
                        // ...
                        // Fechar o BottomSheet
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
