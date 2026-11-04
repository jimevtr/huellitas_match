import 'package:flutter/material.dart';

class CatalogoColors {
  static const fondo = Color(0xFFFAF7F2);
  static const terracota = Color(0xFFBF573F);
  static const suave = Color(0xFFF7E9E0);
  static const texto = Color(0xFF35312C);
  static const secundario = Color(0xFF8A847C);
  static const verdeSuave = Color(0xFFECF0E6);
  static const verde = Color(0xFF68775D);
}

ThemeData buildCatalogoTheme() => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: CatalogoColors.fondo,
  colorScheme: ColorScheme.fromSeed(
    seedColor: CatalogoColors.terracota,
    primary: CatalogoColors.terracota,
    surface: Colors.white,
    onSurface: CatalogoColors.texto,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: CatalogoColors.fondo,
    foregroundColor: CatalogoColors.texto,
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.all(16),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFE8E2DA)),
    ),
    prefixIconColor: CatalogoColors.secundario,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  ),
);
