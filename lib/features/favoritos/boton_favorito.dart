import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:huellitas_match/models/mascota_model.dart';

import 'package:huellitas_match/features/favoritos/favoritos_provider.dart';

class BotonFavorito extends StatelessWidget {
  final Mascota mascota;
  final bool compacto;
  const BotonFavorito({
    super.key,
    required this.mascota,
    this.compacto = false,
  });

  @override
  Widget build(BuildContext context) {
    final guardada = context.watch<FavoritosProvider>().esFavorito(mascota.id);
    void cambiar() =>
        context.read<FavoritosProvider>().toggleFavorito(mascota.id);
    final icono = guardada ? Icons.favorite : Icons.favorite_border;
    final texto = guardada ? 'Quitar de favoritos' : 'Guardar en favoritos';
    if (compacto) {
      return IconButton(
        tooltip: texto,
        onPressed: cambiar,
        color: Theme.of(context).colorScheme.primary,
        icon: Icon(icono, size: 21),
      );
    }
    return FilledButton.icon(
      onPressed: cambiar,
      icon: Icon(icono),
      label: Text(texto),
    );
  }
}
