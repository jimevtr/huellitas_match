import 'package:flutter_test/flutter_test.dart';
import 'package:huellitas_match/mascota_repository.dart';
import 'package:huellitas_match/features/sugerencias/sugerencias_service.dart';
import 'package:huellitas_match/features/encuesta/encuesta_provider.dart';

void main() {
  test('La encuesta requiere las cinco respuestas y puede limpiarse', () {
    final encuesta = EncuestaProvider();
    encuesta.setEspacio('pequeño');
    encuesta.setTiempoCuidados('suficiente');
    encuesta.setActividad('activa');
    expect(encuesta.encuestaCompleta, isFalse);
    encuesta.setExperiencia('básica');
    encuesta.setTamanoPreferido('pequeño');
    expect(encuesta.encuestaCompleta, isTrue);
    expect(encuesta.preguntasRespondidas, 5);
    encuesta.limpiarEncuesta();
    expect(encuesta.preguntasRespondidas, 0);
  });
  test('Experiencia y tamaño cambian el orden de sugerencias', () {
    final mascotas = MascotaRepository().obtenerMascotas();
    String primera(String experiencia, String tamano) =>
        SugerenciasService.ordenarSugerencias(
          mascotas: mascotas,
          espacioUsuario: 'pequeño',
          tiempoUsuario: 'moderado',
          actividadUsuario: 'activa',
          experienciaUsuario: experiencia,
          tamanoUsuario: tamano,
          getEspacio: (m) => m.espacio,
          getTiempo: (m) => m.tiempoCuidados,
          getActividad: (m) => m.actividad,
          getExperiencia: (m) => m.experiencia,
          getTamano: (m) => m.tamano,
        ).first.nombre;
    expect(primera('básica', 'pequeño'), 'Milo');
    expect(primera('ninguna', 'mediano'), 'Luna');
  });
  test('Las 243 combinaciones conservan las ocho mascotas ordenadas', () {
    final mascotas = MascotaRepository().obtenerMascotas();
    var comprobadas = 0;
    for (final espacio in ['pequeño', 'mediano', 'amplio']) {
      for (final tiempo in ['poco', 'moderado', 'suficiente']) {
        for (final actividad in ['tranquila', 'moderada', 'activa']) {
          for (final experiencia in ['ninguna', 'básica', 'mucha']) {
            for (final tamano in ['pequeño', 'mediano', 'grande']) {
              final ordenadas = SugerenciasService.ordenarSugerencias(
                mascotas: mascotas,
                espacioUsuario: espacio,
                tiempoUsuario: tiempo,
                actividadUsuario: actividad,
                experienciaUsuario: experiencia,
                tamanoUsuario: tamano,
                getEspacio: (m) => m.espacio,
                getTiempo: (m) => m.tiempoCuidados,
                getActividad: (m) => m.actividad,
                getExperiencia: (m) => m.experiencia,
                getTamano: (m) => m.tamano,
              );
              expect(
                ordenadas.map((m) => m.id).toSet(),
                mascotas.map((m) => m.id).toSet(),
              );
              expect(ordenadas.length, 8);
              comprobadas++;
            }
          }
        }
      }
    }
    expect(comprobadas, 243);
  });
}
