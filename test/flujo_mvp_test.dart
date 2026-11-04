import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:huellitas_match/main.dart';
import 'package:huellitas_match/mascota_card.dart';
import 'package:huellitas_match/features/encuesta/encuesta_screen.dart';

void main() {
  testWidgets('Encuesta, sugerencias, detalle y favoritos comparten estado', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(480, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    Future<void> pulsar(String texto) async {
      if (find.text(texto).evaluate().isEmpty) {
        await tester.scrollUntilVisible(
          find.text(texto),
          180,
          scrollable: find.byType(Scrollable).last,
        );
      }
      final objetivo = find.text(texto).last;
      await tester.ensureVisible(objetivo);
      await tester.pumpAndSettle();
      await tester.tap(objetivo);
      await tester.pumpAndSettle();
    }

    await pulsar('Comenzar encuesta');
    await pulsar('Ver sugerencias');
    expect(find.byType(EncuestaScreen), findsOneWidget);
    expect(
      find.text('Por favor responde las 5 preguntas para continuar.'),
      findsOneWidget,
    );
    await tester.ensureVisible(find.text('Pequeño').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pequeño').first);
    await tester.pumpAndSettle();
    await pulsar('Moderado');
    await pulsar('Activa');
    await pulsar('Básica');
    // Pequeño aparece en espacio y en tamaño; pulsar usa la última opción.
    await pulsar('Pequeño');
    await pulsar('Ver sugerencias');
    expect(find.text('Tu próximo match'), findsOneWidget);
    expect(
      tester.widget<MascotaCard>(find.byType(MascotaCard).first).mascota.nombre,
      'Milo',
    );
    await tester.tap(find.text('Ver detalle').first);
    await tester.pumpAndSettle();
    expect(find.textContaining('Coincide con tus respuestas'), findsOneWidget);
    await pulsar('Guardar en favoritos');
    expect(find.text('Quitar de favoritos'), findsOneWidget);
    await pulsar('Volver');
    await pulsar('Favoritos');
    expect(find.text('Milo'), findsOneWidget);
    await pulsar('Ver detalle →');
    await pulsar('Quitar de favoritos');
    await pulsar('Volver');
    expect(find.text('Aún no tienes favoritos'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Explorar sin encuesta permite filtrar y limpiar búsqueda', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Explorar catálogo'));
    await tester.tap(find.text('Explorar catálogo'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Gatos'));
    await tester.pumpAndSettle();
    expect(find.text('Milo'), findsOneWidget);
    expect(find.text('Luna'), findsNothing);
    await tester.enterText(find.byType(TextField), 'inexistente');
    await tester.pumpAndSettle();
    expect(
      find.text('No encontramos mascotas con esa búsqueda.'),
      findsOneWidget,
    );
    await tester.tap(find.byTooltip('Limpiar búsqueda'));
    await tester.pumpAndSettle();
    expect(find.text('Milo'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
