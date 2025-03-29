import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:viayage_app/screens/auth_check_screen.dart';
import 'package:viayage_app/services/auth_service.dart';
import 'package:viayage_app/views/login_page.dart';
import 'package:viayage_app/views/register_page.dart';
import 'package:viayage_app/views/home_page.dart';
import 'package:viayage_app/views/forgot_password_page.dart';
import 'package:viayage_app/views/reset_password_page.dart';
import 'package:viayage_app/views/main_screen.dart';
import 'package:viayage_app/views/questionnaire/questionnaire_step1.dart';
import 'package:viayage_app/views/questionnaire/questionnaire_step2.dart';
import 'package:viayage_app/views/questionnaire/questionnaire_step3.dart';
import 'package:viayage_app/views/questionnaire/questionnaire_step4.dart';
import 'package:viayage_app/views/questionnaire/questionnaire_step5.dart';
import 'package:viayage_app/views/questionnaire/questionnaire_step6.dart';
import 'package:viayage_app/widgets/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/check-auth': (context) => AuthCheckScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/main': (context) => MainScreen(),
        '/home': (context) => HomePage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/reset-password': (context) => ResetPasswordPage(token: ''), // temporal
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
        const Locale('es', 'ES'),
      ],
    );
  }
}
