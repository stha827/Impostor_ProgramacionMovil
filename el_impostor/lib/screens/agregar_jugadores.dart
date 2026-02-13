import 'package:el_impostor/screens/jugar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:el_impostor/screens/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // Indicamos la función base al ejecutar
  @override
  void initState() {
    super.initState();
    cargarNombres();
  }

  void agregarJugadores() {
    setState(() {
      jugadores++;
      nombresJugadores.add("");
    });
  }

  void eliminarJugadores() {
    setState(() {
      if (jugadores > 3) {
        jugadores--;
        if (nombresJugadores.length != jugadores) {
          nombresJugadores.removeLast();
        }
      } else {
        jugadores == 3;
      }
    });
  }

  // Función para GUARDAR los nombres en el almacenamiento local
  Future<void> guardarNombres() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < nombresJugadores.length; i++) {
      await prefs.setString('jugador_$i', nombresJugadores[i]);
    }
  }

  // Función para CARGAR los nombres al iniciar la app
  Future<void> cargarNombres() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var i = 0; i < jugadores; i++) {
        nombresJugadores[i] =
            prefs.getString('jugador_$i') ?? "Jugador ${i + 1}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                agregarJugadores();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  MediaQuery.of(context).size.height * 0.225,
                  MediaQuery.of(context).size.width * 0.3,
                ),
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
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                eliminarJugadores();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  MediaQuery.of(context).size.height * 0.225,
                  MediaQuery.of(context).size.width * 0.3,
                ),
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
          height: 550,
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              for (var i = 0; i < jugadores; i++)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    color: const Color.fromARGB(255, 217, 226, 232),
                    child: Center(
                      child: TextFormField(
                        style: GoogleFonts.pirataOne(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 168, 153, 181),
                        ),
                        initialValue: nombresJugadores[i],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Añade un nombre',
                          border: InputBorder.none,
                        ),
                        onChanged: (nombre) {
                          nombresJugadores[i] = nombre;
                          guardarNombres();
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Text(
          'Cantidad de jugadores: $jugadores',
          style: GoogleFonts.pirataOne(
            fontSize: 17,
            color: const Color.fromARGB(255, 80, 7, 109),
          ),
        ),
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
