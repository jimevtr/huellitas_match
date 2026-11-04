import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mascota_catalog_screen.dart';
import 'mascota_repository.dart';
import 'features/encuesta/encuesta_provider.dart';
import 'features/encuesta/encuesta_screen.dart';
import 'features/favoritos/favoritos_screen.dart';
import 'features/favoritos/boton_favorito.dart';
import 'features/sugerencias/sugerencias_service.dart';

class CatalogoIntegradoScreen extends StatelessWidget {
  const CatalogoIntegradoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final encuesta = context.watch<EncuestaProvider>();
    final mascotas = MascotaRepository().obtenerMascotas();
    final ordenadas = SugerenciasService.ordenarSugerencias(
      mascotas: mascotas,
      espacioUsuario: encuesta.espacio,
      tiempoUsuario: encuesta.tiempoCuidados,
      actividadUsuario: encuesta.actividad,
      getEspacio: (m) => m.espacio,
      getTiempo: (m) => m.tiempoCuidados,
      getActividad: (m) => m.actividad,
    );
    final motivos = <String, String>{};
    if (encuesta.encuestaCompleta) {
      for (final mascota in ordenadas) {
        final coincidencias = <String>[];
        if (SugerenciasService.coincide(mascota.espacio, encuesta.espacio)) {
          coincidencias.add('espacio');
        }
        if (SugerenciasService.coincide(
          mascota.tiempoCuidados,
          encuesta.tiempoCuidados,
        )) {
          coincidencias.add('tiempo de cuidados');
        }
        if (SugerenciasService.coincide(
          mascota.actividad,
          encuesta.actividad,
        )) {
          coincidencias.add('actividad');
        }
        if (coincidencias.isNotEmpty) {
          motivos[mascota.id] =
              'Coincide con tus respuestas sobre ${coincidencias.join(', ')}. Es una orientación inicial, no una garantía de compatibilidad.';
        }
      }
    }
    return MascotaCatalogScreen(
      mascotasOrdenadas: ordenadas,
      sugerencias: motivos,
      construirFavorito: (m) => BotonFavorito(mascota: m),
      construirCorazon: (m) => BotonFavorito(mascota: m, compacto: true),
      abrirEncuesta: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => const EncuestaScreen(volverAlCatalogo: true),
        ),
      ),
      abrirFavoritos: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => FavoritosScreen(todasLasMascotas: mascotas),
        ),
      ),
    );
  }
}
