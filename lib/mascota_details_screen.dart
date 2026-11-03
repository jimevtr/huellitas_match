import 'package:flutter/material.dart';

import 'mascota_model.dart';

class MascotaDetailsScreen extends StatelessWidget {
  final Mascota mascota;
  final String? motivoSugerencia;
  final Widget Function(Mascota mascota)? construirFavorito;

  const MascotaDetailsScreen({
    super.key,
    required this.mascota,
    this.motivoSugerencia,
    this.construirFavorito,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(mascota.nombre)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.asset(
                    mascota.rutaImagen,
                    fit: BoxFit.cover,
                    errorBuilder: (_, error, stack) =>
                        const Center(child: Icon(Icons.pets, size: 80)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(mascota.nombre, style: tema.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                '${mascota.especie} · ${mascota.edad} años · ${mascota.tamano}',
              ),
              const SizedBox(height: 16),
              Text(mascota.descripcion),
              const SizedBox(height: 20),
              Text('Sus cuidados', style: tema.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('Actividad: ${mascota.actividad}'),
              Text(
                'Espacio: ${mascota.espacio == 'pequeno' ? 'pequeño' : mascota.espacio}',
              ),
              Text('Tiempo de cuidados: ${mascota.tiempoCuidados}'),
              if (motivoSugerencia != null) ...[
                const SizedBox(height: 20),
                Text(
                  'Por qué podría encajar',
                  style: tema.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(motivoSugerencia!),
              ],
              if (construirFavorito != null) ...[
                const SizedBox(height: 24),
                construirFavorito!(mascota),
              ],
              const SizedBox(height: 20),
              Text(
                'Ficha de demostración. Esta mascota no es un anuncio real de adopción.',
                style: tema.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
