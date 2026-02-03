import 'package:el_impostor/screens/agregar_jugadores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:el_impostor/screens/globals.dart';

// Pantalla de inicio con el Drawer
class Jugar extends StatelessWidget {
  const Jugar({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 56, 56, 54),
        child: JugarContenido(),
      ),
    );
  }
}

class JugarContenido extends StatefulWidget {
  const JugarContenido({super.key});
  @override
  JugarState createState() {
    return JugarState();
  }
}

//Cuerpo
class JugarState extends State<JugarContenido> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 650,
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              for (var i = 0; i < jugadores; i++)
                Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: Container(
                    color: const Color.fromARGB(255, 168, 153, 181),
                    child: Center(
                      child: Text(
                        'Jugador número ${i + 1}',
                        style: GoogleFonts.pirataOne(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 217, 226, 232),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Jugadores()),
            );
            ();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(100, 50),
            shadowColor: const Color.fromARGB(255, 0, 0, 0),
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text(
            "Terminar partida",
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
