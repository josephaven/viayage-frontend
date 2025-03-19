import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static String baseUrl = "http://10.0.2.2:3000/auth"; // Para el backend local

  // Método para iniciar sesión
  static Future<bool> login(String email, String password) async {
    var response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    return response.statusCode == 200;
  }

  // Método para registrarse
  static Future<bool> register(String email, String password) async {
    var response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    return response.statusCode == 201;
  }
}
