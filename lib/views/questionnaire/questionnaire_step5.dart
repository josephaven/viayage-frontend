import 'package:flutter/material.dart';
import 'package:viayage_app/views/questionnaire/questionnaire_step6.dart';

class QuestionnaireStep5 extends StatefulWidget {
  final Map<String, dynamic> responses;
  final bool isEditing;
  QuestionnaireStep5({required this.responses, this.isEditing = false});

  @override
  _QuestionnaireStep5State createState() => _QuestionnaireStep5State();
}

class _QuestionnaireStep5State extends State<QuestionnaireStep5> {
  String? selected;

  final List<Map<String, String>> options = [
    {"label": "Menos de 30 min", "image": "assets/duration/duracion.png"},
    {"label": "30 - 60 min", "image": "assets/duration/duracion.png"},
    {"label": "Más de 1 hora", "image": "assets/duration/duracion.png"},
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
        "visitDuration": selected,
      };

      Navigator.pushNamed(
        context,
        "/questionnaire-step6",
        arguments: updatedResponses,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.responses.containsKey("visitDuration")) {
      selected = widget.responses["visitDuration"];
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
                            Text(option["label"]!, textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
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
                      "visitDuration": selected,
                    };

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuestionnaireStep6(
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
