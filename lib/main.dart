import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/bienvenida/bienvenida_screen.dart';
import 'features/encuesta/encuesta_provider.dart';
import 'features/favoritos/favoritos_provider.dart';

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
        theme: AppTheme.lightTheme,
        home: const BienvenidaScreen(),
      ),
    );
  }
}