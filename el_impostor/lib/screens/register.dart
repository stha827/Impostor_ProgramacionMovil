// ignore_for_file: unused_field
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_impostor/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Pantalla de inicio con el Drawer
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 126, 113, 91),
              Color.fromARGB(255, 241, 230, 211),
            ],
            stops: [0.3, 0.75],
          ),
        ),
        child: RegisterContenido(),
      ),
    );
  }
}

class RegisterContenido extends StatefulWidget {
  const RegisterContenido({super.key});
  @override
  RegisterState createState() {
    return RegisterState();
  }
}

//Cuerpo
class RegisterState extends State<RegisterContenido> {
  // ignore: prefer_final_fields
  String _nombre = '';
  String _correo = '';
  String _password = '';
  String? _errorMessage;

  // Función para manejar el registro de usuario
  Future<void> _registerUser() async {
    setState(() {
      _errorMessage = null;
    });

    try {
      // Creamos el usuario
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _correo.trim(),
            password: _password,
          );

      print('Usuario Auth creado: ${userCredential.user?.email}');

      // Obtenemos el ID
      String uid = userCredential.user!.uid;

      // Creamos un documento
      await FirebaseFirestore.instance.collection('jugadores').doc(uid).set({
        'email': _correo.trim(),
        'nombre': _nombre,
        'escapadas_exitosas': 0,
        'escapadas_fallidas': 0,
        'fecha_registro': FieldValue.serverTimestamp(),
      });

      print('Base de datos creada para el usuario $uid');

      // Cambiamos de pantalla
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'La contraseña es demasiado débil.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Ya existe una cuenta con este correo electrónico.';
      } else if (e.code == 'invalid-email') {
        message = 'El formato del correo electrónico no es válido.';
      } else {
        message = 'Error al registrar: ${e.message}';
      }
      setState(() {
        _errorMessage = message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ocurrió un error inesperado.';
      });
      print('Error general: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      children: [
        Column(
          children: [
            Image.asset(
              "assets/registro/logoBasico.png",
              // height: MediaQuery.of(context).size.height * 0.2,
              // width: MediaQuery.of(context).size.width * 0.2,
            ),
            SizedBox(height: 10),
            Text(
              "Empieza tu camino...",
              style: GoogleFonts.pirataOne(fontSize: 44),
            ),
          ],
        ),
        SizedBox(height: 40),
        Column(
          children: [
            Container(
              color: const Color.fromARGB(195, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Introduce tu correo",
                    style: GoogleFonts.pirataOne(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 0, 0, 0),
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
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 10, right: 10),
                    child: _crearPassword(),
                  ),
                  // Mostrar el mensaje de error en caso de que haya uno
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        _errorMessage!,
                        style: GoogleFonts.pirataOne(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ElevatedButton(
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(375, 50),
                      shadowColor: const Color.fromARGB(255, 43, 38, 0),
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

  Widget _crearEmail() {
    return TextField(
      onChanged: (valor) => setState(() {
        _correo = valor;
      }),
      keyboardType: TextInputType.emailAddress,
      style: GoogleFonts.pirataOne(fontSize: 16.0, color: Colors.white),
      cursorColor: const Color.fromARGB(255, 135, 111, 85),
      decoration: InputDecoration(
        hintText: 'emailpersonal@correo.es',
        hintStyle: GoogleFonts.pirataOne(
          color: Color.fromARGB(255, 63, 57, 46),
        ),
        labelText: 'Email Personal',
        labelStyle: GoogleFonts.pirataOne(
          color: Color.fromARGB(255, 161, 161, 161),
        ),
        suffixIcon: const Icon(
          Icons.email,
          color: Color.fromARGB(255, 135, 111, 85),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 0, 0, 0),
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
      style: GoogleFonts.pirataOne(fontSize: 16.0, color: Colors.white),
      cursorColor: const Color.fromARGB(255, 135, 111, 85),
      decoration: InputDecoration(
        hintText: 'usuario123456...',
        hintStyle: GoogleFonts.pirataOne(
          color: Color.fromARGB(255, 63, 57, 46),
        ),
        labelText: 'Contraseña',
        labelStyle: GoogleFonts.pirataOne(
          color: Color.fromARGB(255, 161, 161, 161),
        ),
        suffixIcon: const Icon(
          Icons.email,
          color: Color.fromARGB(255, 135, 111, 85),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 0, 0, 0),
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
