import 'package:flutter/material.dart';

class QuestionnaireStep1 extends StatefulWidget {
  @override
  _QuestionnaireStep1State createState() => _QuestionnaireStep1State();
}

class _QuestionnaireStep1State extends State<QuestionnaireStep1> {
  Set<String> selectedOptions = {};
  final List<Map<String, String>> interests = [
    {"label": "Cultura e historia", "image": "assets/interests/cultura.png"},
    {"label": "Naturaleza y aventuras", "image": "assets/interests/naturaleza.png"},
    {"label": "Gastronomía", "image": "assets/interests/gastronomia.png"},
    {"label": "Vida nocturna", "image": "assets/interests/nocturna.png"},
    {"label": "Compras", "image": "assets/interests/compras.png"},
    {"label": "Relax y Bienestar", "image": "assets/interests/relax.png"},
  ];

  void toggleSelection(String label) {
    setState(() {
      if (selectedOptions.contains(label)) {
        selectedOptions.remove(label);
      } else if (selectedOptions.length < 3) {
        selectedOptions.add(label);
      }
    });
  }

  void goToNextStep() {
    Navigator.pushNamed(
      context,
      "/questionnaire-step2",
      arguments: {
        "travelInterests": selectedOptions.toList(),
      },
    );
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
              Text("Intereses de viaje", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Selecciona hasta 3 opciones principales", style: TextStyle(fontSize: 14)),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: interests.map((interest) {
                    bool isSelected = selectedOptions.contains(interest["label"]);
                    return GestureDetector(
                      onTap: () => toggleSelection(interest["label"]!),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xFFE0EBF6) : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(interest["image"]!, height: 60),
                            SizedBox(height: 10),
                            Text(interest["label"]!, style: TextStyle(fontSize: 14)),
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
                  onPressed: selectedOptions.isNotEmpty ? goToNextStep: null,
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
