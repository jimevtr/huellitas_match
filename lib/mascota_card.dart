import 'package:flutter/material.dart';

import 'mascota_model.dart';

class MascotaCard extends StatelessWidget {
  final Mascota mascota;
  final VoidCallback onTap;
  const MascotaCard({super.key, required this.mascota, required this.onTap});

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: ListTile(
      contentPadding: const EdgeInsets.all(12),
      leading: Image.asset(
        mascota.rutaImagen,
        width: 64,
        height: 64,
        fit: BoxFit.cover,
      ),
      title: Text(mascota.nombre),
      subtitle: Text('${mascota.especie} · Actividad ${mascota.actividad}'),
      trailing: TextButton(onPressed: onTap, child: const Text('Ver detalle')),
      onTap: onTap,
    ),
  );
}
