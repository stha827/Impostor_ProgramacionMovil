import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class FlipCardWidget extends StatefulWidget {
  final String nombreJugador;
  const FlipCardWidget({super.key, required this.nombreJugador});
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
                        child: _buildBackCard(),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

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

  Widget _buildBackCard() {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 217, 226, 232),
      ),
      alignment: Alignment.center,
      child: Text(
        'Salvado\nPalabra: a',
        style: GoogleFonts.pirataOne(
          fontSize: 23,
          color: const Color.fromARGB(255, 168, 153, 181),
        ),
      ),
    );
  }
}
