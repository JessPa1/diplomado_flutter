import 'package:http/http.dart' as http;

import 'generic_response.dart';
import 'dart:convert';
import 'generic_response_products.dart';

class NetworkHelper {
  //constructor
  NetworkHelper();

  Future<GenericResponseProducts> getProducts() async {
    final String apiUrl = 'https://taecel.com/app/api/getProducts';
    final response = await http.post(apiUrl, body: {
      "key": "ef8daab0154efcc9bc128889c7bc1156",
      "nip": "cd48668567ea4831b2feb75b5475ef02"
    });

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return genericResponseProductsFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<dynamic> submitPago(
      String producto, String referencia, double monto) async {
    final String apiUrl = 'https://taecel.com/app/api/RequestTXN';

    var body = monto == 0
        ? {
            "key": "ef8daab0154efcc9bc128889c7bc1156",
            "nip": "cd48668567ea4831b2feb75b5475ef02",
            "producto": producto,
            "referencia": referencia,
          }
        : {
            "key": "ef8daab0154efcc9bc128889c7bc1156",
            "nip": "cd48668567ea4831b2feb75b5475ef02",
            "producto": producto,
            "referencia": referencia,
            "monto": monto.toString()
          };

    final response = await http.post(apiUrl, body: body);

    if (response.statusCode == 200) {
      Map<String, dynamic> valor = json.decode(response.body);
      final String responseString = response.body;
      if (!valor["success"]) {
        return valor;
      } else {
        return valor;
      }
    } else {
      return null;
    }
  }
}
