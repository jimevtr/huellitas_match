import 'package:flutter/material.dart';

import 'package:huellitas_match/core/theme/catalogo_theme.dart';
import 'package:huellitas_match/models/mascota_model.dart';

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

  Widget etiqueta(String texto, Color color, Color fondo) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      color: fondo,
      borderRadius: BorderRadius.circular(7),
    ),
    child: Text(texto, style: TextStyle(color: color, fontSize: 12)),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leadingWidth: 105,
      leading: TextButton.icon(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.chevron_left, size: 20),
        label: const Text('Volver'),
        style: TextButton.styleFrom(foregroundColor: CatalogoColors.texto),
      ),
      actions: [
        if (motivoSugerencia != null)
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: etiqueta(
              'Tu match',
              CatalogoColors.terracota,
              CatalogoColors.suave,
            ),
          ),
      ],
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: AspectRatio(
                aspectRatio: 1.1,
                child: Image.asset(
                  mascota.rutaImagen,
                  fit: BoxFit.cover,
                  errorBuilder: (_, error, stack) =>
                      const Center(child: Icon(Icons.pets, size: 70)),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              mascota.nombre,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: CatalogoColors.texto,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${mascota.especie} | ${mascota.edad} años',
              style: const TextStyle(color: CatalogoColors.secundario),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                etiqueta(
                  'Tamaño ${mascota.tamano.toLowerCase()}',
                  CatalogoColors.terracota,
                  CatalogoColors.suave,
                ),
                etiqueta(
                  'Actividad ${mascota.actividad}',
                  CatalogoColors.verde,
                  CatalogoColors.verdeSuave,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.auto_awesome_outlined,
                        size: 18,
                        color: CatalogoColors.terracota,
                      ),
                      SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          'Una compañía a tu ritmo',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    mascota.descripcion,
                    style: const TextStyle(
                      color: CatalogoColors.secundario,
                      height: 1.6,
                    ),
                  ),
                  if (motivoSugerencia != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      motivoSugerencia!,
                      style: const TextStyle(
                        color: CatalogoColors.verde,
                        height: 1.5,
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    'Espacio: ${mascota.espacio == 'pequeno' ? 'pequeño' : mascota.espacio} · Cuidados: ${mascota.tiempoCuidados}',
                    style: const TextStyle(
                      color: CatalogoColors.secundario,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Icon(Icons.pets, size: 14, color: CatalogoColors.verde),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Un paseo. Muchas historias por compartir.',
                    style: TextStyle(
                      fontSize: 11,
                      color: CatalogoColors.secundario,
                    ),
                  ),
                ),
              ],
            ),
            if (construirFavorito != null) ...[
              const SizedBox(height: 14),
              construirFavorito!(mascota),
            ],
            const SizedBox(height: 20),
            const Text(
              'Ficha e imagen de demostración.',
              style: TextStyle(fontSize: 10, color: CatalogoColors.secundario),
            ),
          ],
        ),
      ),
    ),
  );
}
