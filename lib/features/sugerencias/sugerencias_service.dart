// Reglas sencillas para ordenar sugerencias comparando respuestas con mascotas.
// Sin porcentajes inventados.

class SugerenciasService {
  static String normalizar(String valor) => valor
      .trim()
      .toLowerCase()
      .replaceAll('ñ', 'n')
      .replaceAll('á', 'a')
      .replaceAll('é', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ú', 'u');

  static bool coincide(String valor, String? respuesta) =>
      respuesta != null &&
      normalizar(valor == 'alto' ? 'suficiente' : valor) ==
          normalizar(respuesta == 'alto' ? 'suficiente' : respuesta);
  static List<T> ordenarSugerencias<T>({
    required List<T> mascotas,
    required String? espacioUsuario,
    required String? tiempoUsuario,
    required String? actividadUsuario,
    required String Function(T mascota) getEspacio,
    required String Function(T mascota) getTiempo,
    required String Function(T mascota) getActividad,
    String? experienciaUsuario,
    String? tamanoUsuario,
    String Function(T mascota)? getExperiencia,
    String Function(T mascota)? getTamano,
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

      if (getExperiencia != null) {
        if (coincide(getExperiencia(a), experienciaUsuario)) scoreA++;
        if (coincide(getExperiencia(b), experienciaUsuario)) scoreB++;
      }
      if (getTamano != null) {
        if (coincide(getTamano(a), tamanoUsuario)) scoreA++;
        if (coincide(getTamano(b), tamanoUsuario)) scoreB++;
      }
      final resultado = scoreB.compareTo(scoreA);
      return resultado != 0
          ? resultado
          : mascotas.indexOf(a).compareTo(mascotas.indexOf(b));
    });

    return listaOrdenada;
  }
}
