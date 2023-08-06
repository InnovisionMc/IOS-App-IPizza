import 'package:flutter/material.dart';
import '../../model/estabelecimento.dart';
import 'package:intl/intl.dart';

class SelectedProductBottomSheet extends StatefulWidget {
  final Produto product;
  const SelectedProductBottomSheet({Key? key, required this.product})
      : super(key: key);

  @override
  State<SelectedProductBottomSheet> createState() =>
      _SelectedProductBottomSheetState();
}

class _SelectedProductBottomSheetState
    extends State<SelectedProductBottomSheet> {
  late List<int> selectedQuantities;
  late List<bool> addButtonsPressed;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');

  @override
  void initState() {
    super.initState();
    selectedQuantities = List.filled(widget.product.itensAdicionais.length, 0);
    addButtonsPressed =
        List.filled(widget.product.itensAdicionais.length, false);
  }

  double get totalAdditionalItems {
    double total = 0;
    for (var i = 0; i < widget.product.itensAdicionais.length; i++) {
      total += widget.product.itensAdicionais[i].valorItemAdicional *
          selectedQuantities[i];
    }
    return total;
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
                itemCount: widget.product.itensAdicionais.length, // Tamanho da lista
                itemBuilder: (context, index) {
                  var item = widget.product.itensAdicionais[index];
                  String descricaoAleatoria =
                      'Descrição aleatória para ' + item.tituloItemAdicional;
                  return ListTile(
                    title: Text(
                      item.tituloItemAdicional,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(descricaoAleatoria),
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
                            if (addButtonsPressed[index])
                              IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.remove),
                                onPressed: selectedQuantities[index] > 0
                                    ? () {
                                  setState(() {
                                    selectedQuantities[index]--;
                                    if (selectedQuantities[index] == 0)
                                      addButtonsPressed[index] = false;
                                  });
                                }
                                    : null,
                              ),
                            if (addButtonsPressed[index])
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
                                  addButtonsPressed[index] = true;
                                });
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
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: Text(
                          'Adicionar ${formatCurrency.format(widget.product.valorProduto + totalAdditionalItems)}',
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
