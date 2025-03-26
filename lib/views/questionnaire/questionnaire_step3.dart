import 'package:flutter/material.dart';
import 'package:viayage_app/views/questionnaire/questionnaire_step4.dart';

class QuestionnaireStep3 extends StatefulWidget {
  final Map<String, dynamic> responses;
  final bool isEditing;
  QuestionnaireStep3({required this.responses, this.isEditing = false});

  @override
  _QuestionnaireStep3State createState() => _QuestionnaireStep3State();
}

class _QuestionnaireStep3State extends State<QuestionnaireStep3> {
  String? selected;

  final List<Map<String, String>> options = [
    {"label": "Vegana", "image": "assets/food/vegana.png"},
    {"label": "Vegetariana", "image": "assets/food/vegetariana.png"},
    {"label": "Ninguna, como de todo", "image": "assets/food/ninguna.png"},
    {"label": "Sin gluten", "image": "assets/food/singluten.png"},
  ];

  void selectOption(String label) {
    setState(() {
      selected = label;
    });
  }

  void goNext() {
    if (selected != null) {
      final updatedResponses = {
        ...widget.responses,
        "foodPreference": selected,
      };

      Navigator.pushNamed(
        context,
        "/questionnaire-step4",
        arguments: updatedResponses,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.responses.containsKey("foodPreference")) {
      selected = widget.responses["foodPreference"];
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
              Text("Preferencias gastronómicas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Selecciona si tienes alguna restricción o preferencia alimentaria", style: TextStyle(fontSize: 14)),
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
                      ? () {
                    final updatedResponses = {
                      ...widget.responses,
                      "foodPreference": selected,
                    };

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuestionnaireStep4(
                          responses: updatedResponses,
                          isEditing: widget.isEditing,
                        ),
                      ),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE0EBF6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Siguiente", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
