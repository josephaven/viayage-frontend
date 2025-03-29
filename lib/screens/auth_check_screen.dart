import 'package:flutter/material.dart';
import 'package:viayage_app/services/auth_service.dart';

class AuthCheckScreen extends StatefulWidget {
  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    final isLoggedIn = await AuthService.isLoggedIn();

    if (!isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      final completed = await AuthService.hasCompletedQuestionnaire();
      if (completed) {
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        Navigator.pushReplacementNamed(context, '/questionnaire-step1');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
