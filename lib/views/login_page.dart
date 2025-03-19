import 'package:flutter/material.dart';
import '../widgets/text_input.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text;
    String password = passwordController.text;

    bool success = await AuthService.login(email, password);

    if (success) {
      // Navegar a la pantalla principal (a implementar)
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Credenciales incorrectas")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(label: "Correo", controller: emailController),
          TextInput(label: "Contraseña", controller: passwordController, isPassword: true),
          ElevatedButton(
            onPressed: login,
            child: Text("Iniciar sesión"),
          ),
          TextButton(
            onPressed: () {}, // Implementar recuperación de contraseña
            child: Text("Recuperar contraseña"),
          ),
        ],
      ),
    );
  }
}
