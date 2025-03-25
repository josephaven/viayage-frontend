import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'views/welcome_page.dart';
import 'views/login_page.dart';
import 'views/register_page.dart';
import 'views/home_page.dart';
import 'views/forgot_password_page.dart';
import 'views/reset_password_page.dart';


import 'views/questionnaire/questionnaire_step1.dart';
import 'views/questionnaire/questionnaire_step2.dart';
import 'views/questionnaire/questionnaire_step3.dart';
import 'views/questionnaire/questionnaire_step4.dart';
import 'views/questionnaire/questionnaire_step5.dart';
import 'views/questionnaire/questionnaire_step6.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => WelcomePage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => HomePage(),
        "/forgot-password": (context) => ForgotPasswordPage(),
        "/reset-password": (context) => ResetPasswordPage(token: ''), // temporal
      },
      onGenerateRoute: (settings) {
        final args = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case '/questionnaire-step1':
            return MaterialPageRoute(builder: (_) => QuestionnaireStep1());
          case '/questionnaire-step2':
            return MaterialPageRoute(builder: (_) => QuestionnaireStep2(responses: args!));
          case '/questionnaire-step3':
            return MaterialPageRoute(builder: (_) => QuestionnaireStep3(responses: args!));
          case '/questionnaire-step4':
            return MaterialPageRoute(builder: (_) => QuestionnaireStep4(responses: args!));
          case '/questionnaire-step5':
            return MaterialPageRoute(builder: (_) => QuestionnaireStep5(responses: args!));
          case '/questionnaire-step6':
            return MaterialPageRoute(builder: (_) => QuestionnaireStep6(responses: args!));
        }
        return null;
      },

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', 'ES'), // Español
      ],
    );
  }
}


