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
                '${encuestaProvider.preguntasRespondidas}/5',
                style: const TextStyle(
                  color: Color(0xFFBF573F),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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

            // 1. Espacio
            const Text(
              '01. ¿Cuánto espacio tienes?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildThreeOptionsRow(
              opciones: ['Pequeño', 'Mediano', 'Amplio'],
              seleccionado: encuestaProvider.espacio,
              onSelected: (val) => encuestaProvider.setEspacio(val),
            ),
            const SizedBox(height: 24),

            // 2. Tiempo para cuidados
            const Text(
              '02. ¿Tiempo para cuidados?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildThreeOptionsRow(
              opciones: ['Poco', 'Moderado', 'Suficiente'],
              seleccionado: encuestaProvider.tiempoCuidados,
              onSelected: (val) => encuestaProvider.setTiempoCuidados(val),
            ),
            const SizedBox(height: 24),

            // 3. Nivel de actividad
            const Text(
              '03. ¿Tu nivel de actividad?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildThreeOptionsRow(
              opciones: ['Tranquila', 'Moderada', 'Activa'],
              seleccionado: encuestaProvider.actividad,
              onSelected: (val) => encuestaProvider.setActividad(val),
            ),
            const SizedBox(height: 24),

            // 4. Experiencia previa
            const Text(
              '04. ¿Tienes experiencia previa?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildThreeOptionsRow(
              opciones: ['Ninguna', 'Básica', 'Mucha'],
              seleccionado: encuestaProvider.experiencia,
              onSelected: (val) => encuestaProvider.setExperiencia(val),
            ),
            const SizedBox(height: 24),

            // 5. Tamaño de mascota preferido (reemplaza la pregunta repetida de espacio/vivienda)
            const Text(
              '05. ¿Qué tamaño de mascota prefieres?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildThreeOptionsRow(
              opciones: ['Pequeño', 'Mediano', 'Grande'],
              seleccionado: encuestaProvider.tamanoPreferido,
              onSelected: (val) => encuestaProvider.setTamanoPreferido(val),
            ),
            const SizedBox(height: 40),

            BotonPrincipal(
              texto: 'Ver sugerencias',
              onPressed: () {
                if (!encuestaProvider.encuestaCompleta) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Por favor responde las 5 preguntas para continuar.',
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

  Widget _buildThreeOptionsRow({
    required List<String> opciones,
    required String? seleccionado,
    required Function(String) onSelected,
  }) {
    return Row(
      children: opciones.map((opcion) {
        bool isSelected = seleccionado == opcion.toLowerCase();
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () => onSelected(opcion.toLowerCase()),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFF7E9E0) : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFBF573F)
                        : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    opcion,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFFBF573F)
                          : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
