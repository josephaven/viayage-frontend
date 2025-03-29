import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../services/auth_service.dart';



class QuestionnaireStep6 extends StatefulWidget {
  final Map<String, dynamic> responses;
  final bool isEditing;
  QuestionnaireStep6({required this.responses, this.isEditing = false});

  @override
  _QuestionnaireStep6State createState() => _QuestionnaireStep6State();
}

class _QuestionnaireStep6State extends State<QuestionnaireStep6> {
  String? selected;

  final List<Map<String, String>> options = [
    {"label": "Bajo", "image": "assets/budget/presupuesto.png"},
    {"label": "Medio", "image": "assets/budget/presupuesto.png"},
    {"label": "Alto", "image": "assets/budget/presupuesto.png"},
  ];

  void selectOption(String label) {
    setState(() {
      selected = label;
    });
  }

  Future<void> submitAnswers() async {
    final allResponses = {
      ...widget.responses,
      "budget": selected,
    };

    try {
      final token = await AuthService.getToken();
      final response = await http.post(
        Uri.parse("http://10.0.2.2:3000/questionnaire"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(allResponses),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al enviar el cuestionario")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fallo al conectar con el servidor")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.responses.containsKey("budget")) {
      selected = widget.responses["budget"];
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Cuestionario", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text("Tiempo de permanencia en cada lugar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Selecciona un promedio aproximado", style: TextStyle(fontSize: 14)),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: options.map((option) {
                    bool isSelected = selected == option["label"];
                    return GestureDetector(
                      onTap: () => selectOption(option["label"]!),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xFFE0EBF6) : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected
                              ? Border.all(color: Colors.blueGrey.shade700, width: 2)
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(option["image"]!, height: 100),
                            SizedBox(height: 10),
                            Text(option["label"]!, style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: selected != null
                      ? () async {
                    final updatedResponses = {
                      ...widget.responses,
                      "budget": selected,
                    };

                    final token = await AuthService.getToken();

                    final response = await http.post(
                      Uri.parse("https://d80d-189-203-85-208.ngrok-free.app/questionnaire"),
                      headers: {
                        "Authorization": "Bearer $token",
                        "Content-Type": "application/json",
                      },
                      body: jsonEncode(updatedResponses),
                    );

                    if (response.statusCode == 200 || response.statusCode == 201) {
                      Navigator.pushReplacementNamed(context, "/main");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error al guardar el cuestionario")),
                      );
                    }
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE0EBF6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Finalizar", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
