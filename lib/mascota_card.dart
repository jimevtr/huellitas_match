import 'package:flutter/material.dart';

import 'catalogo_theme.dart';
import 'mascota_model.dart';

class MascotaCard extends StatelessWidget {
  final Mascota mascota;
  final VoidCallback onTap;
  const MascotaCard({super.key, required this.mascota, required this.onTap});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: .035),
          blurRadius: 18,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  mascota.rutaImagen,
                  width: 92,
                  height: 146,
                  fit: BoxFit.cover,
                  errorBuilder: (_, error, stack) => const SizedBox(
                    width: 92,
                    height: 146,
                    child: Icon(Icons.pets),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mascota.nombre,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: CatalogoColors.texto,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${mascota.especie} · ${mascota.edad} años',
                      style: const TextStyle(
                        color: CatalogoColors.secundario,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: CatalogoColors.verdeSuave,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Actividad ${mascota.actividad}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: CatalogoColors.verde,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: onTap,
                        style: TextButton.styleFrom(
                          backgroundColor: CatalogoColors.suave,
                          foregroundColor: CatalogoColors.terracota,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Ver detalle',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Icon(Icons.arrow_forward_rounded, size: 17),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
