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
                  SizedBox(height: 30),
                  Text(
                    "Introduce tu correo",
                    style: GoogleFonts.pirataOne(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 248, 240, 225),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 10, right: 10),
                    child: _crearEmail(),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Introduce tu contraseña",
                    style: GoogleFonts.pirataOne(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 248, 240, 225),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 10, right: 10),
                    child: _crearPassword(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      reset();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(375, 50),
                      shadowColor: const Color.fromARGB(255, 255, 255, 255),
                      elevation: 5,
                      backgroundColor: const Color.fromARGB(255, 241, 230, 211),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      "Iniciar Sesión",
                      style: GoogleFonts.pirataOne(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
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
      style: GoogleFonts.pirataOne(fontSize: 16.0),
      cursorColor: const Color.fromARGB(255, 135, 111, 85),
      decoration: InputDecoration(
        hintText: 'emailpersonal@correo.es',
        hintStyle: GoogleFonts.pirataOne(
          color: Color.fromARGB(255, 63, 57, 46),
        ),
        labelText: 'Email Personal',
        labelStyle: GoogleFonts.pirataOne(
          color: Color.fromARGB(255, 68, 68, 68),
        ),
        suffixIcon: const Icon(
          Icons.email,
          color: Color.fromARGB(255, 135, 111, 85),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 135, 111, 85),
            width: 4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 135, 111, 85),
            width: 4,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 135, 111, 85),
            width: 4,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 135, 111, 85),
            width: 4,
          ),
        ),
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
      style: GoogleFonts.pirataOne(fontSize: 16.0),
      cursorColor: const Color.fromARGB(255, 135, 111, 85),
      decoration: InputDecoration(
        hintText: 'usuario123456...',
        hintStyle: GoogleFonts.pirataOne(
          color: Color.fromARGB(255, 63, 57, 46),
        ),
        labelText: 'Contraseña',
        labelStyle: GoogleFonts.pirataOne(
          color: Color.fromARGB(255, 68, 68, 68),
        ),
        suffixIcon: const Icon(
          Icons.email,
          color: Color.fromARGB(255, 135, 111, 85),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 135, 111, 85),
            width: 4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 135, 111, 85),
            width: 4,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 135, 111, 85),
            width: 4,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 135, 111, 85),
            width: 4,
          ),
        ),
      ),
    );
  }
}
