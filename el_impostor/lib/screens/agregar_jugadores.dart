import 'package:el_impostor/screens/jugar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:el_impostor/screens/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Pantalla encargada de añadir o quitar más jugadores
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
  // Función nada más inicializar
  @override
  void initState() {
    super.initState();
    cargarNombres();
  }

  //Función para agregar jugadores
  void agregarJugadores() {
    setState(() {
      jugadores++;
      nombresJugadores.add("");
    });
  }

  //Función para eliminar jugadores (mínimo 3 jugadores)
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

  // Función para guardar los nombres localmente
  Future<void> guardarNombres() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < nombresJugadores.length; i++) {
      await prefs.setString('jugador_$i', nombresJugadores[i]);
    }
  }

  // Función para cargar los nombres localmente al inicializar
  Future<void> cargarNombres() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var i = 0; i < jugadores; i++) {
        nombresJugadores[i] =
            prefs.getString('jugador_$i') ?? "Jugador ${i + 1}";
      }
    });
  }

  //Cuerpo de la pantalla
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        //Botones
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            //Botón añadir
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
            //Botón eliminar
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
          //Visualizar los jugadores
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              // Nota --> la variable jugadores se encuentra en el fichero de variables globales (globals.dart)
              for (var i = 0; i < jugadores; i++)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    color: const Color.fromARGB(255, 217, 226, 232),
                    child: Center(
                      //Sirve para poder cambiar el texto
                      child: TextFormField(
                        style: GoogleFonts.pirataOne(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 168, 153, 181),
                        ),
                        // Nota --> la lista nombresJugadores[] se encuentra en el fichero de variables globales (globals.dart)
                        initialValue: nombresJugadores[i],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Añade un nombre',
                          border: InputBorder.none,
                        ),
                        //En caso de que se cambie cambiamos el valor y guardamos
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
        //Botón para empezar a jugar
        Row(
          children: [
            SizedBox(width: 10),
            Positioned(child: Center(child: MostrarSnackBar())),
            SizedBox(width: 90),
            ElevatedButton(
              onPressed: () {
                //En caso de que haya algún campo vacío se asignará un valor automáticamente
                setState(() {
                  for (int i = 0; i < jugadores; i++) {
                    if (nombresJugadores[i].trim().isEmpty) {
                      nombresJugadores[i] = "Jugador ${i + 1}";
                    }
                  }
                });
                guardarNombres();
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
        ),
      ],
    );
  }
}

class MostrarSnackBar extends StatelessWidget {
  const MostrarSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: const Color.fromARGB(255, 0, 0, 0),
          elevation: 2,
          minimumSize: Size(0, 40),
          shape: CircleBorder(),
          backgroundColor: Colors.black,
        ),
        onPressed: () {
          final snackBar = SnackBar(
            content: Text(
              "Uno de nosotros es un impostor(no sabe la palabra secreta) tenemos que intentar pillar quien es diciendo palabras relacionadas con la plabara secreta, las palabras que tengan menos sentido puede que las haya dicho el impostor, o puede que no...",
              style: GoogleFonts.almendra(
                fontSize: 15,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            action: SnackBarAction(label: 'x', onPressed: () {}),
            backgroundColor: const Color.fromARGB(255, 168, 153, 181),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Text(
          'i',
          style: GoogleFonts.pirataOne(
            fontSize: 17,
            color: const Color.fromARGB(255, 168, 153, 181),
          ),
        ),
      ),
    );
  }
}
