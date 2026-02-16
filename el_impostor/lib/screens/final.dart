import 'package:el_impostor/screens/agregar_jugadores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:el_impostor/screens/globals.dart';

// Clase con la pantalla final
class Final extends StatelessWidget {
  const Final({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 56, 56, 54),
        child: FinalContenido(),
      ),
    );
  }
}

class FinalContenido extends StatefulWidget {
  const FinalContenido({super.key});
  @override
  FinalState createState() {
    return FinalState();
  }
}

//Cuerpo
class FinalState extends State<FinalContenido> {
  String impostor = nombresJugadores[numeroAleatorio];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 650,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Container(
              color: const Color.fromARGB(255, 217, 226, 232),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'El impostor era... \n$impostor',
                  style: GoogleFonts.pirataOne(
                    fontSize: 30,
                    color: const Color.fromARGB(255, 168, 153, 181),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        // Botón para volver a jugar
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Jugadores()),
            );
            ();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(100, 65),
            shadowColor: const Color.fromARGB(255, 0, 0, 0),
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text(
            "Volver a jugar",
            style: GoogleFonts.pirataOne(
              fontSize: 20,
              color: const Color.fromARGB(255, 168, 153, 181),
            ),
          ),
        ),
      ],
    );
  }
}
