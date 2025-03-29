import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  String email = '';
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('https://d80d-189-203-85-208.ngrok-free.app/users/profile'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("DEBUG => Perfil completo: $data");
      setState(() {
        nombreController.text = data["nombre"] ?? '';
        apellidoController.text = data["apellido"] ?? '';
        email = data["email"] ?? '';
        if (data["fechaNacimiento"] != null) {
          fechaController.text = DateFormat('dd / MM / yyyy')
              .format(DateTime.parse(data["fechaNacimiento"]));
        }
        selectedGender = data["genero"];
      });
    } else {
      print("Error al obtener perfil: ${response.statusCode}");
    }
  }

  Future<void> updateProfile() async {
    final token = await AuthService.getToken();
    final response = await http.patch(
      Uri.parse('http://10.0.2.2:3000/users/profile'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "nombre": nombreController.text,
        "apellido": apellidoController.text,
        "fechaNacimiento": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd / MM / yyyy').parse(fechaController.text),
        ),
        "genero": selectedGender,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Perfil actualizado correctamente")),
      );
      Navigator.pop(context); // Regresa a la pantalla anterior
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al actualizar perfil")),
      );
    }
  }

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF0A1D33),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        fechaController.text =
            DateFormat('dd / MM / yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Editar perfil", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(Icons.account_circle, size: 80, color: Colors.black87),
              SizedBox(height: 20),

              buildTextField("Nombre*", nombreController),
              buildTextField("Apellido*", apellidoController),
              buildDisabledField("Correo electrónico *", email),
              buildDateField("Fecha de nacimiento *", fechaController),
              buildDropdownField(),

              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE0EBF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Guardar", style: TextStyle(color: Colors.black)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildDisabledField(String label, String? value) {
    final displayText = value != null && value.isNotEmpty ? value : "Cargando...";

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: displayText,
        enabled: false,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.lock_outline),
        ),
      ),
    );
  }


  Widget buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: selectDate,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: DropdownButtonFormField<String>(
          value: selectedGender,
          decoration: InputDecoration(
            labelText: "Género *",
            border: OutlineInputBorder(),
          ),
          items: ["masculino", "femenino", "otro"].map((gender) {
            return DropdownMenuItem(
              value: gender,
              child: Text(gender[0].toUpperCase() + gender.substring(1)),
            );
          }).toList(),
          onChanged: (value) => setState(() => selectedGender = value),
        ),
      ),
    );
  }
}
