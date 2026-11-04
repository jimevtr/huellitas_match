import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:huellitas_match/mascota_repository.dart';
import 'package:huellitas_match/features/sugerencias/sugerencias_service.dart';

void main() {
  final mascotas = MascotaRepository().obtenerMascotas();
  final esperadas = {
    'pequeño/moderado/tranquila': 'Luna',
    'pequeño/moderado/activa': 'Milo',
    'pequeño/alto/tranquila': 'Nala',
    'pequeño/alto/activa': 'Kira',
    'amplio/moderado/tranquila': 'Bruno',
    'amplio/moderado/activa': 'Max',
    'amplio/alto/tranquila': 'Coco',
    'amplio/alto/activa': 'Rocky',
  };
  for (final entrada in esperadas.entries) {
    test('Primera sugerencia para ${entrada.key}: ${entrada.value}', () {
      final respuestas = entrada.key.split('/');
      final ordenadas = SugerenciasService.ordenarSugerencias(
        mascotas: mascotas,
        espacioUsuario: respuestas[0],
        tiempoUsuario: respuestas[1],
        actividadUsuario: respuestas[2],
        getEspacio: (m) => m.espacio,
        getTiempo: (m) => m.tiempoCuidados,
        getActividad: (m) => m.actividad,
      );
      expect(ordenadas.first.nombre, entrada.value);
      expect(ordenadas.length, mascotas.length);
      expect(mascotas.first.nombre, 'Luna');
    });
  }
  test('Fichas con identificadores únicos y fotos locales existentes', () {
    expect(mascotas.map((m) => m.id).toSet().length, mascotas.length);
    for (final mascota in mascotas) {
      expect(
        File(mascota.rutaImagen).existsSync(),
        isTrue,
        reason: mascota.nombre,
      );
    }
  });
}
