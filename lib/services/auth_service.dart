import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class AuthService {
  static String baseUrl = "https://d80d-189-203-85-208.ngrok-free.app/auth";
  static final _storage = FlutterSecureStorage();


  // Método para iniciar sesión
  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      print("Código de estado: ${response.statusCode}");
      print("Respuesta: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final token = data["access_token"];

        if (token != null) {
          await FlutterSecureStorage().write(key: "token", value: token);
          return true;
        } else {
          print("No se encontró access_token en la respuesta.");
          return false;
        }
      } else {
        print("Fallo al iniciar sesión: código ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Excepción al hacer login: $e");
      return false;
    }
  }



  // Método para verificar si ya respondió el cuestionario
  static Future<bool> hasCompletedQuestionnaire() async {
    final token = await _storage.read(key: "token");

    final response = await http.get(
      Uri.parse("https://d80d-189-203-85-208.ngrok-free.app/questionnaire/status"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("Respuesta del cuestionario: ${response.body}");

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
      Uri.parse("https://d80d-189-203-85-208.ngrok-free.app/users/profile"),
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

  static Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: "token");
    return token != null && token.isNotEmpty;
  }



}
