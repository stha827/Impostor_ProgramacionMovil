import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// CLASE SACADA DE VIDEOTUTORIAL DE YOUTUBE --> https://youtu.be/OjqWQrqTfWY?si=uUc5DfgXJw11D4FW
// Clase encargada de que nuestra tarjeta se pueda girar
class FlipCardWidget extends StatefulWidget {
  //Parámetros obligatorios
  final String nombreJugador;
  final bool diferente;
  final String palabra;
  const FlipCardWidget({
    super.key,
    required this.nombreJugador,
    required this.diferente,
    required this.palabra,
  });
  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    // Función nada más inicializar
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  //Función que comprueba que tarjeta mostrar al girar
  void _toggleCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isFront = !_isFront;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //Cuerpo de la tarjeta, indica la animación a realizar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _toggleCard,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.rotationY(_animation.value * 3.14159),
                alignment: Alignment.center,
                child: _animation.value < 0.5
                    ? _buildFrontCard()
                    : Transform.scale(
                        scaleX: -1,
                        scaleY: 1,
                        //En caso de que ese jugador sea el impostor, la tarjeta trasera va a ser distinta
                        child: widget.diferente
                            ? _buildBackCardImpostor()
                            : _buildBackCard(),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Parte frontal de la tarjeta
  Widget _buildFrontCard() {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 168, 153, 181),
      ),
      child: Center(
        child: Text(
          widget.nombreJugador,
          textAlign: TextAlign.center,
          style: GoogleFonts.pirataOne(
            fontSize: 23,
            color: const Color.fromARGB(255, 217, 226, 232),
          ),
        ),
      ),
    );
  }

  //Parte trasera normal de la tarjeta
  Widget _buildBackCard() {
    String palabra = widget.palabra;
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 217, 226, 232),
      ),
      alignment: Alignment.center,
      child: Text(
        'Salvado\nPalabra: $palabra',
        style: GoogleFonts.pirataOne(
          fontSize: 23,
          color: const Color.fromARGB(255, 168, 153, 181),
        ),
      ),
    );
  }

  //Parte trasera de la tarjeta si somos impostor
  Widget _buildBackCardImpostor() {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 217, 226, 232),
      ),
      alignment: Alignment.center,
      child: Text(
        'Eres el impostor',
        style: GoogleFonts.pirataOne(
          fontSize: 23,
          color: const Color.fromARGB(255, 168, 153, 181),
        ),
      ),
    );
  }
}
