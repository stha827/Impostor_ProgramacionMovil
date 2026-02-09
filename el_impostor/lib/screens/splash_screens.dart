import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:el_impostor/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  // Creamos una pantalla que muestra imágenes repetidas en filas y columnas de forma responsive
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: 'assets/ImpostorLogoAnimado.gif',
        splashIconSize: 2000.0,
        centered: true,
        nextScreen: const HomeScreen(),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        duration: 1100,
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/logoAnimado.gif', width: 65.9)],
        ),
      ),
    );
  }
}
