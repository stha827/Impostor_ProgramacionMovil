int jugadores = 3;
List<String> nombresJugadores = ["Jugador 1", "Jugador 2", "Jugador 3"];
List<String> nombres() {
  for (int i = 3; i < jugadores; i++) {
    nombresJugadores[i] == "Jugador ${i + 1}";
  }
  return nombresJugadores;
}
