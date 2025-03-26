import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class AuthService {
  static String baseUrl = "http://10.0.2.2:3000/auth";
  static final _storage = FlutterSecureStorage();


  // Método para iniciar sesión
  static Future<bool> login(String email, String password) async {
    var response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      await FlutterSecureStorage().write(key: "token", value: data["access_token"]); // Guardar token
      return true;
    }

    return false;
  }


  // Método para verificar si ya respondió el cuestionario
  static Future<bool> hasCompletedQuestionnaire() async {
    final token = await _storage.read(key: "token");

    final response = await http.get(
      Uri.parse("http://10.0.2.2:3000/questionnaire/status"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["completed"] == true;
    }

    return false;
  }


  // Método para registrarse
  static Future<bool> register({
    required String nombre,
    required String apellido,
    required String fechaNacimiento,
    required String genero,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nombre": nombre,
          "apellido": apellido,
          "fechaNacimiento": fechaNacimiento,
          "genero": genero.toLowerCase(), // para que sea "masculino", no "Masculino"
          "email": email,
          "password": password,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }


  // Método para cerrar sesión
  static Future<void> logout() async {
    await _storage.delete(key: "token");
  }


  // Método para obtener el token almacenado
  static Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }
  static Future<bool> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Método para devolver los datos del usuario en su perfil
  static Future<Map<String, dynamic>?> getUserProfile() async {
    final token = await _storage.read(key: "token");

    final response = await http.get(
      Uri.parse("http://10.0.2.2:3000/users/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }


}
