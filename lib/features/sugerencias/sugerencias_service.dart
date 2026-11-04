// Reglas sencillas para ordenar sugerencias comparando respuestas con mascotas.
// Sin porcentajes inventados.

class SugerenciasService {
  static List<T> ordenarSugerencias<T>({
    required List<T> mascotas,
    required String? espacioUsuario,
    required String? tiempoUsuario,
    required String? actividadUsuario,
    required String Function(T mascota) getEspacio,
    required String Function(T mascota) getTiempo,
    required String Function(T mascota) getActividad,
  }) {
    if (espacioUsuario == null || tiempoUsuario == null || actividadUsuario == null) {
      return mascotas;
    }

    List<T> listaOrdenada = List.from(mascotas);

    listaOrdenada.sort((a, b) {
      int scoreA = 0;
      int scoreB = 0;

      if (getEspacio(a).toLowerCase() == espacioUsuario.toLowerCase()) scoreA++;
      if (getTiempo(a).toLowerCase() == tiempoUsuario.toLowerCase()) scoreA++;
      if (getActividad(a).toLowerCase() == actividadUsuario.toLowerCase()) scoreA++;

      if (getEspacio(b).toLowerCase() == espacioUsuario.toLowerCase()) scoreB++;
      if (getTiempo(b).toLowerCase() == tiempoUsuario.toLowerCase()) scoreB++;
      if (getActividad(b).toLowerCase() == actividadUsuario.toLowerCase()) scoreB++;

      return scoreB.compareTo(scoreA); // Mayor coincidencia al inicio
    });

    return listaOrdenada;
  }
}