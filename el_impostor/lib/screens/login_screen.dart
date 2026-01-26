import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Pantalla de inicio con el Drawer
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 241, 230, 211),
        child: Contenido(),
      ),
    );
  }
}

//Cuerpo
class Contenido extends StatelessWidget {
  const Contenido({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/login/logoBasico.png",
                // height: MediaQuery.of(context).size.height * 0.2,
                // width: MediaQuery.of(context).size.width * 0.2,
              ),
              Text("Bienvenida/o ", style: GoogleFonts.pirataOne(fontSize: 44)),
              Text(
                "Abre el menú lateral para navegar",
                style: GoogleFonts.pirataOne(fontSize: 25),
              ),
            ],
          ),
          Text(
            "Abre el menú lateral para navegar",
            style: GoogleFonts.pirataOne(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
