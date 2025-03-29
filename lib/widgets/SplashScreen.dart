import 'package:flutter/material.dart';
import 'package:viayage_app/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndRedirect();
  }

  void _checkAuthAndRedirect() async {
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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png", height: 140),
            SizedBox(height: 30),
            CircularProgressIndicator(
              color: Colors.blueGrey.shade900,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
