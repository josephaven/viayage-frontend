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
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    bool success = await AuthService.login(email, password);

    if (success) {
      bool hasCompleted = await AuthService.hasCompletedQuestionnaire();

      if (hasCompleted) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/questionnaire-step1");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Correo o contraseña incorrectos")),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/logo.png',
              height: 100,
            ),

            SizedBox(height: 40),

            // Contenedor del formulario
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),

                  // Ingresar correo
                  SizedBox(
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextInput(label: "Correo", controller: emailController),
                    ),
                  ),
                  SizedBox(height: 12),

                  // Ingresar contraseña
                  SizedBox(
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextInput(label: "Contraseña", controller: passwordController, isPassword: true),
                    ),
                  ),
                  SizedBox(height: 25),

                  // Botón de Iniciar sesión
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE0EBF6), // Color del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: login,
                      child: Text(
                        "Iniciar sesión",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Botón de Recuperar contraseña
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/forgot-password");
                    },
                    child: Text(
                      "Recuperar contraseña",
                      style: TextStyle(fontSize: 16, color: Colors.white54),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
