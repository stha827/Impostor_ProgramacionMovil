import 'package:el_impostor/screens/jugar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:el_impostor/screens/globals.dart';

// Pantalla de inicio con el Drawer
class Jugadores extends StatelessWidget {
  const Jugadores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 242, 239, 233),
        child: JugadoresContenido(),
      ),
    );
  }
}

class JugadoresContenido extends StatefulWidget {
  const JugadoresContenido({super.key});
  @override
  JugadoresState createState() {
    return JugadoresState();
  }
}

//Cuerpo
class JugadoresState extends State<JugadoresContenido> {
  void agregarJugadores() {
    setState(() {
      jugadores++;
    });
  }

  void eliminarJugadores() {
    setState(() {
      if (jugadores > 3) {
        jugadores--;
      } else {
        jugadores == 3;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                agregarJugadores();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 50),
                shadowColor: const Color.fromARGB(255, 255, 255, 255),
                elevation: 5,
                backgroundColor: const Color.fromARGB(255, 142, 153, 163),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Text(
                "Añadir Jugadores",
                style: GoogleFonts.pirataOne(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                eliminarJugadores();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 50),
                shadowColor: const Color.fromARGB(255, 255, 255, 255),
                elevation: 5,
                backgroundColor: const Color.fromARGB(255, 107, 123, 142),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Text(
                "Eliminar Jugadores",
                style: GoogleFonts.pirataOne(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 600,
          //Utilizamos GridView para poder hacer un scroll en caso de que haya muchos elementos
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              for (var i = 0; i < jugadores; i++)
                Container(
                  color: const Color.fromARGB(255, 217, 226, 232),
                  child: Text(
                    'Jugador número ${i + 1}',
                    style: GoogleFonts.pirataOne(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 168, 153, 181),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Text('$jugadores'),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Jugar()),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(100, 50),
            shadowColor: const Color.fromARGB(255, 255, 255, 255),
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 168, 153, 181),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text(
            "Jugar",
            style: GoogleFonts.pirataOne(
              fontSize: 20,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ],
    );
  }
}
