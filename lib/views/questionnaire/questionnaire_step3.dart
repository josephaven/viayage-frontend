import 'package:flutter/material.dart';

class QuestionnaireStep3 extends StatefulWidget {
  final Map<String, dynamic> responses;
  QuestionnaireStep3({required this.responses});

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
      widget.responses["foodPreference"] = selected!;
      Navigator.pushNamed(
        context,
        "/questionnaire-step4",
        arguments: widget.responses,
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
              Text("¿Qué tipo de comida prefieres?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
                  onPressed: selected != null ? goNext : null,
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
