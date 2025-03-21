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
    String email = emailController.text.trim();
    String confirmEmail = confirmEmailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();


    bool emailValid = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email);
    if (!emailValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ingresa un correo válido")),
      );
      return;
    }


    if (email != confirmEmail) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Los correos no coinciden")),
      );
      return;
    }


    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("La contraseña debe tener al menos 6 caracteres")),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registro exitoso. Ahora puedes iniciar sesión.")),
      );
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
      backgroundColor: Colors.white, // Fondo blanco
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
                color: Colors.blueGrey[900], // Fondo oscuro
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),

                  // Campos de texto
                  SizedBox(
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Fondo claro
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextInput(label: "Correo", controller: emailController),
                    ),
                  ),
                  SizedBox(height: 12),

                  SizedBox(
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Fondo claro
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextInput(label: "Confirmar correo", controller: confirmEmailController),
                    ),
                  ),
                  SizedBox(height: 12),

                  SizedBox(
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Fondo claro
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextInput(label: "Contraseña", controller: passwordController, isPassword: true),
                    ),
                  ),
                  SizedBox(height: 12),

                  SizedBox(
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextInput(label: "Confirmar contraseña", controller: confirmPasswordController, isPassword: true),
                    ),
                  ),
                  SizedBox(height: 25),

                  // Botón de "Registrarse"
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
                      onPressed: register,
                      child: Text(
                        "Registrarse",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

