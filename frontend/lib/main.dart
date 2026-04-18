import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const BarberFlowApp());
}

class BarberFlowApp extends StatelessWidget {
  const BarberFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarberFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        // '/home': (context) => const HomeScreen(),
        // '/register': (context) => const RegisterScreen(),
      },
    );
  }
}