import 'package:http/http.dart' as http;

class APIService {
  static Future<void> sendComandaToAPI(String descricao, double valor) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/comandas'),
      headers: {'Content-Type': 'application/json'},
      body: {
        'descricao': descricao,
        'valor': valor.toString(),
      },
    );

    if (response.statusCode == 200) {
      print('Comanda enviada com sucesso');
    } else {
      print('Erro ao enviar a comanda: ${response.body}');
    }
  }
}
