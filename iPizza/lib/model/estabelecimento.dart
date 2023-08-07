class Response {
  final Data data;
  final String? error;
  final int statusCode;

  Response({required this.data, this.error, required this.statusCode});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      data: Data.fromJson(json['data']),
      error: json['error'],
      statusCode: json['statusCode'],
    );
  }
}

class Data {
  final String estabelecimentoId;
  final List<Unidade> listaUnidades;

  Data({required this.estabelecimentoId, required this.listaUnidades});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      estabelecimentoId: json['estabelecimentoId'],
      listaUnidades: (json['listaUnidades'] as List).map((i) => Unidade.fromJson(i)).toList(),
    );
  }
}

class Unidade {
  final String unidadeId;
  final String enderecoUnidade;
  final String cepUnidade;
  final String whatsappUnidade;
  final List<HorarioFuncionamento> horarioFuncionamento;
  final List<Produto> cardapio;

  Unidade({
    required this.unidadeId,
    required this.enderecoUnidade,
    required this.cepUnidade,
    required this.whatsappUnidade,
    required this.horarioFuncionamento,
    required this.cardapio,
  });

  factory Unidade.fromJson(Map<String, dynamic> json) {
    return Unidade(
      unidadeId: json['unidadeId'],
      enderecoUnidade: json['enderecoUnidade'],
      cepUnidade: json['cepUnidade'],
      whatsappUnidade: json['whatsappUnidade'],
      horarioFuncionamento: (json['horarioFuncionamento'] as List).map((i) => HorarioFuncionamento.fromJson(i)).toList(),
      cardapio: (json['cardapio'] as List).map((i) => Produto.fromJson(i)).toList(),
    );
  }
}

class HorarioFuncionamento {
  final String diaSemana;
  final String horarioAbertura;
  final String horarioFechamento;

  HorarioFuncionamento({
    required this.diaSemana,
    required this.horarioAbertura,
    required this.horarioFechamento,
  });

  factory HorarioFuncionamento.fromJson(Map<String, dynamic> json) {
    return HorarioFuncionamento(
      diaSemana: json['diaSemana'],
      horarioAbertura: json['horarioAbertura'],
      horarioFechamento: json['horarioFechamento'],
    );
  }
}

class Produto {
  final String tituloProduto;
  final String descricaoProduto;
  final double valorProduto;
  final double valorProdutoComDesconto;
  final String categoriaProduto;
  final String urlImagemProduto;
  final List<ItemAdicional> itensAdicionais;

  Produto({
    required this.tituloProduto,
    required this.descricaoProduto,
    required this.valorProduto,
    required this.urlImagemProduto,
    required this.valorProdutoComDesconto,
    required this.categoriaProduto,
    required this.itensAdicionais,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      tituloProduto: json['tituloProduto'],
      descricaoProduto: json['descricaoProduto'],
      valorProduto: json['valorProduto'].toDouble(),
      urlImagemProduto: json['urlImagemProduto'],
      valorProdutoComDesconto: json['valorProdutoComDesconto'].toDouble(),
      categoriaProduto: json['categoriaProduto'],
      itensAdicionais: (json['itensAdicionais'] as List).map((i) => ItemAdicional.fromJson(i)).toList(),
    );
  }
}

class ItemAdicional {
  final String tituloItemAdicional;
  final double valorItemAdicional;
  final String descricaoItemAdicional;

  ItemAdicional({
    required this.tituloItemAdicional,
    required this.valorItemAdicional,
    required this.descricaoItemAdicional,
  });

  factory ItemAdicional.fromJson(Map<String, dynamic> json) {
    return ItemAdicional(
      tituloItemAdicional: json['tituloItemAdicional'],
      valorItemAdicional: json['valorItemAdicional'].toDouble(),
        descricaoItemAdicional: json['descricaoItemAdicional']
    );
  }
}
