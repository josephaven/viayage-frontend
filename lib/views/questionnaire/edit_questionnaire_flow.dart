import 'package:flutter/material.dart';
import 'package:viayage_app/views/questionnaire/questionnaire_step1.dart';


class EditQuestionnaireFlow extends StatefulWidget {
  @override
  _EditQuestionnaireFlowState createState() => _EditQuestionnaireFlowState();
}

class _EditQuestionnaireFlowState extends State<EditQuestionnaireFlow> {
  Map<String, dynamic> savedResponses = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSavedQuestionnaire();
  }

  Future<void> loadSavedQuestionnaire() async {
    // TODO: Aquí se llamará al backend para obtener las respuestas guardadas del usuario
    // Por ahora simulamos la carga
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      savedResponses = {
        "travelInterests": ["Cultura e historia", "Gastronomía"],
        "travelCompanion": "Con familia",
        "foodPreference": "Vegano",
        "cityPreference": "Lugares turísticos icónicos",
        "visitDuration": "30 - 60 min",
        "budget": "Medio",
      };
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return QuestionnaireStep1(
      initialResponses: savedResponses,
      isEditing: true,
    );
  }
}
