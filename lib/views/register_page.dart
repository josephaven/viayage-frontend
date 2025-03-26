import 'package:flutter/material.dart';
import '../widgets/text_input.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  DateTime? selectedDate;
  String? selectedGender;

  void register() async {
    final nombre = nameController.text.trim();
    final apellido = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final genero = selectedGender ?? '';
    final fechaNacimiento = selectedDate != null
        ? selectedDate!.toIso8601String().split("T").first
        : '';

    if (nombre.isEmpty || apellido.isEmpty || fechaNacimiento.isEmpty || genero.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor completa todos los campos.")),
      );
      return;
    }

    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Correo no válido")),
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

    final success = await AuthService.register(
      nombre: nombre,
      apellido: apellido,
      fechaNacimiento: fechaNacimiento,
      genero: genero.toLowerCase(),
      email: email,
      password: password,
    );

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al registrarse")),
      );
    }
  }


  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('es', 'ES'),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF263238),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 100),
              SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Nombre
                    buildInputField("Nombre", nameController),
                    SizedBox(height: 12),

                    // Apellido
                    buildInputField("Apellido", lastNameController),
                    SizedBox(height: 12),

                    // Fecha de nacimiento
                    GestureDetector(
                      onTap: _selectDate,
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          selectedDate == null
                              ? 'Fecha de nacimiento'
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    // Género
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        value: selectedGender,
                        isExpanded: true,
                        hint: Text(
                          "Género",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        dropdownColor: Colors.white, // Fondo del dropdown
                        borderRadius: BorderRadius.circular(10),
                        style: TextStyle(color: Colors.black, fontSize: 16), // Texto seleccionado
                        items: ["Masculino", "Femenino", "Otro"]
                            .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(
                            gender,
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                      ),

                    ),

                    SizedBox(height: 12),

                    // Correo
                    buildInputField("Correo", emailController),
                    SizedBox(height: 12),

                    // Contraseña
                    buildInputField("Contraseña", passwordController, isPassword: true),
                    SizedBox(height: 12),

                    // Confirmar Contraseña
                    buildInputField("Confirmar contraseña", confirmPasswordController, isPassword: true),
                    SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE0EBF6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Registrarse",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller, {bool isPassword = false}) {
    return SizedBox(
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextInput(
          label: label,
          controller: controller,
          isPassword: isPassword,
        ),
      ),
    );
  }
}

