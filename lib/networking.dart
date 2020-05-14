import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> updatePrice() async {
  http.Response response = await http.get('https://blockchain.info/ticker');
  if (response.statusCode != 200) {
    print('could not fetch (${response.statusCode})');
    return;
  }
  return jsonDecode(response.body);

}
