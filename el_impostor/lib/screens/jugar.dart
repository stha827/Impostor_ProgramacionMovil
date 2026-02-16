import 'dart:math';
import 'package:el_impostor/screens/final.dart';
import 'package:el_impostor/screens/flipCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:el_impostor/screens/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Clase que contiene la pantalla de juego
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
  String palabra = "";

  // Función nada más inicializar
  @override
  void initState() {
    super.initState();
    numeroAleatorio = Random().nextInt(jugadores);
    palabraAleatoria();
  }

  //Función que conecta con la API y nos asigna una palabra aleatoria
  Future<void> palabraAleatoria() async {
    final url = Uri.parse(
      'https://random-words-api.kushcreates.com/api?language=es&words=1',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // La API devuelve una lista
        List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          setState(() {
            // Extraemos el valor de la clave 'word' ya que la API nos devuelve varios valores
            palabra = data[0]['word'];
          });
          print("Palabra obtenida: $palabra");
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      //En caso de que la API falle y/o no haya conexión asignaremos una palabra manualmente
      setState(() {
        palabra = "Nutria";
      });
    }
  }

  //Cuerpo
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 650,
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              //Añadimos tarjetas segun cantidad de jugadores haya (asignada por la variable global)
              for (var i = 0; i < nombresJugadores.length; i++)
                Padding(
                  padding: EdgeInsets.all(7),
                  child: FlipCardWidget(
                    //Parámetros obligatorios
                    nombreJugador: nombresJugadores[i],
                    diferente: (i == numeroAleatorio),
                    palabra: palabra,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 20),
        //Botón de finalizar partida
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Final()),
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
