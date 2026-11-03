import 'package:flutter/material.dart';

import 'mascota_catalog_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Huellitas Match',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF42766B)),
      ),
      home: const MascotaCatalogScreen(),
    ),
  );
}
