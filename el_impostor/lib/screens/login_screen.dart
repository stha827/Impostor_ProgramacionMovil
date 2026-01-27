import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Pantalla de inicio con el Drawer
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 241, 230, 211),
              Color.fromARGB(255, 126, 113, 91),
            ],
            stops: [0.3, 0.75],
          ),
        ),
        child: LoginContenido(),
      ),
    );
  }
}

class LoginContenido extends StatefulWidget {
  const LoginContenido({super.key});
  @override
  ContenidoState createState() {
    return ContenidoState();
  }
}

//Cuerpo
class ContenidoState extends State<LoginContenido> {
  String _nombre = '';
  String _correo = '';
  String _password = '';
  void reset() {}
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
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
              "Preparate para jugar",
              style: GoogleFonts.pirataOne(fontSize: 25),
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Column(
                children: [
                  Text(
                    "Introduce tu correo",
                    style: GoogleFonts.pirataOne(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 126, 113, 91),
                    ),
                  ),
                  _crearEmail(),
                  SizedBox(height: 10),
                  Text(
                    "Introduce tu contraseña",
                    style: GoogleFonts.pirataOne(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 126, 113, 91),
                    ),
                  ),
                  _crearPassword(),
                  ElevatedButton(
                    onPressed: () {
                      reset();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(390, 50),
                      shadowColor: const Color.fromARGB(255, 255, 255, 255),
                      elevation: 5,
                      backgroundColor: const Color.fromARGB(255, 241, 230, 211),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      "Iniciar Sesión",
                      style: GoogleFonts.bangers(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _crearEmail() {
    return TextField(
      onChanged: (valor) => setState(() {
        _correo = valor;
      }),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'emailpersonal@correo.es',
        hintStyle: TextStyle(color: const Color.fromARGB(255, 126, 113, 91)),
        labelText: 'Email Personal',
        labelStyle: TextStyle(color: Color.fromARGB(255, 241, 230, 211)),
        suffixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  Widget _crearPassword() {
    return TextField(
      onChanged: (valor) => setState(() {
        _password = valor;
      }),
      obscureText: true,
      obscuringCharacter: '♡',
      maxLength: 20,
      decoration: InputDecoration(
        hintText: 'Contraseña de entrada',
        labelText: 'Contraseña',
        suffixIcon: const Icon(Icons.password),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
