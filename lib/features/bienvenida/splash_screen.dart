import 'dart:async';

import 'package:flutter/material.dart';
import 'package:huellitas_match/core/theme/catalogo_theme.dart';
import 'package:huellitas_match/features/bienvenida/bienvenida_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Timer _timer;
  bool _mostrarBienvenida = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      setState(() => _mostrarBienvenida = true);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_mostrarBienvenida) return const BienvenidaScreen();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                color: CatalogoColors.terracota,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.pets_rounded, color: Colors.white, size: 56),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Icon(
                      Icons.favorite_rounded,
                      color: CatalogoColors.suave,
                      size: 17,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Huellitas Match',
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
