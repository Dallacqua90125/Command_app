import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showCommandPopup(BuildContext context) {
    TextEditingController commandController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Borda arredondada no popup
          ),
          title: const Text(
            'Acessar Comanda', 
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          content: TextField(
            controller: commandController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Digite o número da comanda',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o popup
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                String commandNumber = commandController.text;
                if (commandNumber.isNotEmpty) {
                  // Lógica para acessar a comanda
                  print('Número da comanda: $commandNumber');
                  Navigator.of(context).pop(); // Fecha o popup
                } else {
                  // Mostra uma mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, insira o número da comanda.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Confirmar', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco
      appBar: AppBar(
        title: const Text(
          'Bartolomeu',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        centerTitle: true,
        backgroundColor: Colors.black, // Cor da barra de app em preto
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adiciona um padding geral
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Central de Comanda',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.black, // Cor do texto em preto
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  print('Criar comanda');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Borda arredondada no botão
                  ),
                  backgroundColor: Colors.blue, // Cor azul para o botão
                  textStyle: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                ),
                child: const Text('Criar Comanda', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _showCommandPopup(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blue, // Cor azul para o botão
                  textStyle: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                ),
                child: const Text('Acessar Comanda', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
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
