// Reglas sencillas para ordenar sugerencias comparando respuestas con mascotas.
// Sin porcentajes inventados.

class SugerenciasService {
  static String normalizar(String valor) =>
      valor.trim().toLowerCase().replaceAll('ñ', 'n');

  static bool coincide(String valor, String? respuesta) =>
      respuesta != null && normalizar(valor) == normalizar(respuesta);
  static List<T> ordenarSugerencias<T>({
    required List<T> mascotas,
    required String? espacioUsuario,
    required String? tiempoUsuario,
    required String? actividadUsuario,
    required String Function(T mascota) getEspacio,
    required String Function(T mascota) getTiempo,
    required String Function(T mascota) getActividad,
  }) {
    if (espacioUsuario == null ||
        tiempoUsuario == null ||
        actividadUsuario == null) {
      return mascotas;
    }

    List<T> listaOrdenada = List.from(mascotas);

    listaOrdenada.sort((a, b) {
      int scoreA = 0;
      int scoreB = 0;

      if (coincide(getEspacio(a), espacioUsuario)) scoreA++;
      if (coincide(getTiempo(a), tiempoUsuario)) scoreA++;
      if (coincide(getActividad(a), actividadUsuario)) scoreA++;

      if (coincide(getEspacio(b), espacioUsuario)) scoreB++;
      if (coincide(getTiempo(b), tiempoUsuario)) scoreB++;
      if (coincide(getActividad(b), actividadUsuario)) scoreB++;

      final resultado = scoreB.compareTo(scoreA);
      return resultado != 0
          ? resultado
          : mascotas.indexOf(a).compareTo(mascotas.indexOf(b));
    });

    return listaOrdenada;
  }
}
