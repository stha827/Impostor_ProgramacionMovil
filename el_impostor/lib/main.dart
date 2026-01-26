import 'package:el_impostor/screens/splash_screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Impostor',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
