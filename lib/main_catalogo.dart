import 'package:flutter/material.dart';

import 'catalogo_theme.dart';
import 'mascota_catalog_screen.dart';

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
