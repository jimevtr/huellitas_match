import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:huellitas_match/features/catalogo/mascota_catalog_screen.dart';
import 'package:huellitas_match/repositories/mascota_repository.dart';
import 'package:huellitas_match/features/encuesta/encuesta_provider.dart';
import 'package:huellitas_match/features/encuesta/encuesta_screen.dart';
import 'package:huellitas_match/features/favoritos/favoritos_screen.dart';
import 'package:huellitas_match/features/favoritos/boton_favorito.dart';
import 'package:huellitas_match/features/sugerencias/sugerencias_service.dart';

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
      experienciaUsuario: encuesta.experiencia,
      tamanoUsuario: encuesta.tamanoPreferido,
      getExperiencia: (m) => m.experiencia,
      getTamano: (m) => m.tamano,
    );
    final motivos = SugerenciasService.obtenerMotivos(
      mascotas: ordenadas,
      espacio: encuesta.espacio,
      tiempo: encuesta.tiempoCuidados,
      actividad: encuesta.actividad,
      experiencia: encuesta.experiencia,
      tamano: encuesta.tamanoPreferido,
    );
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
