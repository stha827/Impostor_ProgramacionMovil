import 'package:el_impostor/screens/login_screen.dart';
import 'package:flutter/material.dart';

// Pantalla de inicio con el Drawer
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 31, 31, 31),
        child: LoginScreen(),
      ),
    );
  }
}
