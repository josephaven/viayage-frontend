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
      backgroundColor: Colors.white, // Color de fondo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/logo.png',
              height: 100,
            ),

            SizedBox(height: 40), // Espaciado entre logo y formulario

            // Contenedor del formulario
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueGrey[900], // Fondo oscuro
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),

                  // Campos de texto con fondo claro
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Fondo claro
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextInput(label: "Correo", controller: emailController),
                  ),
                  SizedBox(height: 15),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Fondo claro
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextInput(label: "Contraseña", controller: passwordController, isPassword: true),
                  ),
                  SizedBox(height: 25),

                  // Botón de "Iniciar sesión"
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue[100], // Color del botón
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

                  // Botón de "Recuperar contraseña"
                  TextButton(
                    onPressed: () {},
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
