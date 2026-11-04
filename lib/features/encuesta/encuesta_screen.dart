import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/boton_principal.dart';
import 'encuesta_provider.dart';

class EncuestaScreen extends StatelessWidget {
  final bool volverAlCatalogo;
  const EncuestaScreen({super.key, this.volverAlCatalogo = false});

  @override
  Widget build(BuildContext context) {
    final encuestaProvider = Provider.of<EncuestaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('TU MATCH EMPIEZA AQUÍ'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                '${[encuestaProvider.espacio, encuestaProvider.tiempoCuidados, encuestaProvider.actividad].where((r) => r != null).length}/3',
                style: const TextStyle(
                  color: Color(0xFFBF573F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Conozcamos\ntu rutina',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Unas pistas para encontrar a tu compañero ideal.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // Pregunta 1: Espacio
            _buildQuestionTitle('01', '¿Cuánto espacio tienes?'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildOptionButton(
                    titulo: 'Pequeño',
                    seleccionado: encuestaProvider.espacio == 'pequeño',
                    onTap: () => encuestaProvider.setEspacio('pequeño'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildOptionButton(
                    titulo: 'Amplio',
                    seleccionado: encuestaProvider.espacio == 'amplio',
                    onTap: () => encuestaProvider.setEspacio('amplio'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Pregunta 2: Tiempo para cuidados
            _buildQuestionTitle('02', '¿Tiempo para cuidados?'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildOptionButton(
                    titulo: 'Moderado',
                    seleccionado: encuestaProvider.tiempoCuidados == 'moderado',
                    onTap: () => encuestaProvider.setTiempoCuidados('moderado'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildOptionButton(
                    titulo: 'Alto',
                    seleccionado: encuestaProvider.tiempoCuidados == 'alto',
                    onTap: () => encuestaProvider.setTiempoCuidados('alto'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Pregunta 3: Nivel de actividad
            _buildQuestionTitle('03', '¿Tu nivel de actividad?'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildOptionButton(
                    titulo: 'Tranquila',
                    seleccionado: encuestaProvider.actividad == 'tranquila',
                    onTap: () => encuestaProvider.setActividad('tranquila'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildOptionButton(
                    titulo: 'Activa',
                    seleccionado: encuestaProvider.actividad == 'activa',
                    onTap: () => encuestaProvider.setActividad('activa'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Botón Ver sugerencias con validación
            BotonPrincipal(
              texto: 'Ver sugerencias',
              icono: Icons.arrow_forward,
              onPressed: () {
                if (!encuestaProvider.encuestaCompleta) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Por favor responde todas las preguntas para continuar.',
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  return;
                }
                if (volverAlCatalogo) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacementNamed(context, '/catalogo');
                }
              },
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                '✨ Cada rutina tiene una compañía especial',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionTitle(String numero, String pregunta) {
    return Row(
      children: [
        Text(
          numero,
          style: const TextStyle(
            color: Color(0xFFBF573F),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          pregunta,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildOptionButton({
    required String titulo,
    required bool seleccionado,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: seleccionado ? const Color(0xFFF7E9E0) : Colors.white,
          border: Border.all(
            color: seleccionado
                ? const Color(0xFFBF573F)
                : Colors.grey.shade300,
            width: seleccionado ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            titulo,
            style: TextStyle(
              color: seleccionado ? const Color(0xFFBF573F) : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
