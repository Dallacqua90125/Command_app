import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class APIService {
  static Future<void> sendComandaToAPI(String descricao, double valor) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/comandas'),
      headers: {'Content-Type': 'application/json'},
      body: '{"descricao": "$descricao", "valor": $valor}',
    );

    if (response.statusCode == 200) {
      print('Comanda enviada com sucesso');
    } else {
      print('Erro ao enviar a comanda: ${response.body}');
    }
  }
}

class DBHelper {
  static Future<Database> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'comandas.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE comandas(id INTEGER PRIMARY KEY, descricao TEXT, valor REAL)',
        );
      },
      version: 1,
    );
  }

  static Future<void> addComanda(String descricao, double valor) async {
    final db = await initializeDatabase();
    await db.insert(
      'comandas',
      {'descricao': descricao, 'valor': valor},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _createCommand(BuildContext context) async {
    TextEditingController descricaoController = TextEditingController();
    TextEditingController valorController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Criar Comanda',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: valorController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                String descricao = descricaoController.text;
                String valorText = valorController.text;
                double? valor = double.tryParse(valorText);

                if (descricao.isNotEmpty && valor != null) {
                  // Salva no banco local
                  await DBHelper.addComanda(descricao, valor);
                  print('Comanda salva localmente.');

                  // Envia para API
                  await APIService.sendComandaToAPI(descricao, valor);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Comanda criada com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, preencha os campos corretamente.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Salvar', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Comanda'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _createCommand(context),
          child: const Text('Criar Comanda'),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}
