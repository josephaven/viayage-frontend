import 'package:flutter/material.dart';
import '../widgets/text_input.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void register() async {
    String email = emailController.text;
    String confirmEmail = confirmEmailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (email != confirmEmail) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Los correos no coinciden")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Las contraseñas no coinciden")),
      );
      return;
    }

    bool success = await AuthService.register(email, password);

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al registrarse")),
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
          TextInput(label: "Confirmar correo", controller: confirmEmailController),
          TextInput(label: "Contraseña", controller: passwordController, isPassword: true),
          TextInput(label: "Confirmar contraseña", controller: confirmPasswordController, isPassword: true),
          ElevatedButton(
            onPressed: register,
            child: Text("Registrarse"),
          ),
        ],
      ),
    );
  }
}
