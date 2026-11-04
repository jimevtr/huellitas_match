import 'package:flutter/material.dart';

import 'package:huellitas_match/core/theme/catalogo_theme.dart';
import 'package:huellitas_match/features/catalogo/mascota_catalog_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Huellitas Match',
      debugShowCheckedModeBanner: false,
      theme: buildCatalogoTheme(),
      home: const MascotaCatalogScreen(),
    ),
  );
}
