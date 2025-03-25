import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionnaireStep6 extends StatefulWidget {
  final Map<String, dynamic> responses;
  QuestionnaireStep6({required this.responses});

  @override
  _QuestionnaireStep6State createState() => _QuestionnaireStep6State();
}

class _QuestionnaireStep6State extends State<QuestionnaireStep6> {
  String? selected;

  final List<Map<String, String>> options = [
    {"label": "Bajo", "image": "assets/budget/bajo.jpg"},
    {"label": "Medio", "image": "assets/budget/medio.jpg"},
    {"label": "Alto", "image": "assets/budget/alto.jpg"},
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
      final response = await http.post(
        Uri.parse("http://10.0.2.2:3000/questionnaire"),
        headers: {
          "Content-Type": "application/json",
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("¿Cuál es tu presupuesto aproximado para el viaje?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                            Image.asset(option["image"]!, height: 60),
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
                  onPressed: selected != null ? submitAnswers : null,
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
