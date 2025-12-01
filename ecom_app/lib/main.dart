import 'package:flutter/material.dart';
import 'display_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/display",
      routes: {
        "/display": (context) => const DisplayScreen(),
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegistrationScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/dashboard") {
          final args = settings.arguments as Map<String, dynamic>;
          String username = args["username"];

          return MaterialPageRoute(
              builder: (_) => DashboardScreen(username: username));
        }
        return null;
      },
    );
  }
}