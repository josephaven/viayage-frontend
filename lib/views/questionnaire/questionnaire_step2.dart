import 'package:flutter/material.dart';

class QuestionnaireStep2 extends StatefulWidget {
  final Map<String, dynamic> responses;
  QuestionnaireStep2({required this.responses});

  @override
  _QuestionnaireStep2State createState() => _QuestionnaireStep2State();
}

class _QuestionnaireStep2State extends State<QuestionnaireStep2> {
  String? selected;

  final List<Map<String, String>> options = [
    {"label": "Solo", "image": "assets/companion/solo.png"},
    {"label": "Pareja", "image": "assets/companion/pareja.png"},
    {"label": "Amigos", "image": "assets/companion/amigos.png"},
    {"label": "Familia", "image": "assets/companion/familia.png"},
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
        "travelCompanion": selected,
      };

      Navigator.pushNamed(
        context,
        "/questionnaire-step3",
        arguments: updatedResponses,
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
              Text("Cuestionario", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text("Compañía en el viaje", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("¿Con quién viajas?", style: TextStyle(fontSize: 14)),
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
