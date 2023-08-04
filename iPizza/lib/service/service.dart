import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/estabelecimento.dart';

Future<Response?> getEstabelecimentoInfoApi() async {
  var url = Uri.https('carlos2832.c34.integrator.host', '/informacoesEstabelecimento/pizzaria-estellas');

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(jsonResponse);
    return Response.fromJson(jsonResponse);

  } else {
    print('Request failed with status: ${response.statusCode}.');
    return null;
  }
}
