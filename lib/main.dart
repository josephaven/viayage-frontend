import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String backendResponse = "Esperando respuesta...";

  Future<void> checkBackendConnection() async {
    try {
      var url = Uri.parse('http://10.0.2.2:3000/test'); // Emulador de Android usa 10.0.2.2
      var response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          backendResponse = response.body;
        });
      } else {
        setState(() {
          backendResponse = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        backendResponse = "Error de conexión: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkBackendConnection();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Prueba de Conexión")),
        body: Center(child: Text(backendResponse)),
      ),
    );
  }
}
