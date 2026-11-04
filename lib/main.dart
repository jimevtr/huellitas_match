import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/bienvenida/bienvenida_screen.dart';
import 'features/encuesta/encuesta_provider.dart';
import 'features/favoritos/favoritos_provider.dart';
import 'catalogo_integrado_screen.dart';
import 'catalogo_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EncuestaProvider()),
        ChangeNotifierProvider(create: (_) => FavoritosProvider()),
      ],
      child: MaterialApp(
        title: 'Huellitas Match',
        debugShowCheckedModeBanner: false,
        theme: buildCatalogoTheme(),
        routes: {'/catalogo': (_) => const CatalogoIntegradoScreen()},
        builder: (context, child) => ColoredBox(
          color: CatalogoColors.fondo,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: child!,
            ),
          ),
        ),
        home: const BienvenidaScreen(),
      ),
    );
  }
}
