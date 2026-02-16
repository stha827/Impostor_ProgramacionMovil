import 'package:firebase_auth/firebase_auth.dart';
import 'package:el_impostor/screens/agregar_jugadores.dart';
import 'package:el_impostor/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Clase con la Pantalla de Inicio de sesión
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
  //Variables
  String _correo = '';
  String _password = '';
  String? _errorMessage;
  bool _isLoading = false;

  // Función para Iniciar Sesión conectada con Firebase
  Future<void> _loginUser() async {
    //Campos vacíos
    if (_correo.isEmpty || _password.isEmpty) {
      setState(() {
        _errorMessage = "Por favor, llena todos los campos";
      });
      return;
    }
    //Añadimos el estado del botón de inicio de sesión
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Intentamos iniciar sesión en Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _correo.trim(),
        password: _password,
      );

      // Iniciamos sesión en caso de éxito
      if (!mounted) return;
      // Bloqueamos el login para que no se pueda volver
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Jugadores()),
      );
    } on FirebaseAuthException catch (e) {
      // Errores
      String message = '';
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        message = 'Usuario o contraseña incorrectos.';
      } else if (e.code == 'wrong-password') {
        message = 'La contraseña es incorrecta.';
      } else if (e.code == 'invalid-email') {
        message = 'El correo no tiene un formato válido.';
      } else {
        message = 'Error: ${e.message}';
      }

      setState(() {
        _errorMessage = message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ocurrió un error inesperado.';
        _isLoading = false;
      });
    }
  }

  //Cuerpo
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      children: [
        Column(
          children: [
            Image.asset("assets/login/logoBasico.png"),
            Text("Bienvenida/o", style: GoogleFonts.pirataOne(fontSize: 44)),
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
                  // Email
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
                  // Contraseña
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
                  // Mensaje de error
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _errorMessage!,
                        style: GoogleFonts.pirataOne(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  SizedBox(height: 10),
                  //Boton de inicio de sesion
                  // En caso de que esté cargando nos mostrará el símbolo de la rueda girando
                  // En caso contrario nos mostrará el botón para que podamos inoiciar sesión
                  _isLoading
                      ? const CircularProgressIndicator(
                          color: Color.fromARGB(255, 241, 230, 211),
                        )
                      : ElevatedButton(
                          onPressed: _loginUser,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(375, 50),
                            shadowColor: const Color.fromARGB(
                              255,
                              255,
                              255,
                              255,
                            ),
                            elevation: 5,
                            backgroundColor: const Color.fromARGB(
                              255,
                              241,
                              230,
                              211,
                            ),
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
                  SizedBox(height: 20),
                  //Botón de Registro
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(375, 50),
                      shadowColor: const Color.fromARGB(255, 255, 255, 255),
                      elevation: 5,
                      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      "Registrarme",
                      style: GoogleFonts.pirataOne(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 241, 230, 211),
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

  //Widget del campo para escribir un correo
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
      ),
    );
  }

  //Widget del campo para escribir una contraseña
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
          Icons.lock, // Cambié el icono a candado aquí para diferenciar
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
      ),
    );
  }
}
