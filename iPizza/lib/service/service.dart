import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/estabelecimento.dart';

Future<Response?> getEstabelecimentoInfoApi() async {
  var url = Uri.https('itasty.site', '/informacoesEstabelecimento/pizzaria-estellas');

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.utf8.decode(response.bodyBytes);
    var decodedResponse = convert.jsonDecode(jsonResponse) as Map<String, dynamic>;
    print(decodedResponse);
    return Response.fromJson(decodedResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return null;
  }
}
