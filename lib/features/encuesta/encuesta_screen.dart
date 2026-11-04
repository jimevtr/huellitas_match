import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/boton_principal.dart';
import 'encuesta_provider.dart';

class EncuestaScreen extends StatelessWidget {
  const EncuestaScreen({Key? key}) : super(key: key);

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
                encuestaProvider.encuestaCompleta ? '5/5' : '1/5',
                style: const TextStyle(
                  color: Color(0xFFD35400),
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

            _buildQuestionTitle('01', '¿Cuánto espacio tienes?'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildOptionButton(
                    titulo: 'Pequeno',
                    seleccionado: encuestaProvider.espacio == 'pequeno',
                    onTap: () => encuestaProvider.setEspacio('pequeno'),
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
            const SizedBox(height: 24),

            _buildQuestionTitle('04', '¿Tienes experiencia previa?'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildOptionButton(
                    titulo: 'Primeriza',
                    seleccionado: encuestaProvider.experiencia == 'primeriza',
                    onTap: () => encuestaProvider.setExperiencia('primeriza'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildOptionButton(
                    titulo: 'Experta',
                    seleccionado: encuestaProvider.experiencia == 'experta',
                    onTap: () => encuestaProvider.setExperiencia('experta'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildQuestionTitle('05', '¿Tipo de vivienda?'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildOptionButton(
                    titulo: 'Departamento',
                    seleccionado: encuestaProvider.tipoHogar == 'departamento',
                    onTap: () => encuestaProvider.setTipoHogar('departamento'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildOptionButton(
                    titulo: 'Casa con patio',
                    seleccionado: encuestaProvider.tipoHogar == 'casa',
                    onTap: () => encuestaProvider.setTipoHogar('casa'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            BotonPrincipal(
              texto: 'Ver sugerencias',
              icono: Icons.arrow_forward,
              onPressed: () {
                if (!encuestaProvider.encuestaCompleta) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor responde las 5 preguntas para continuar.'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  return;
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
            color: Color(0xFFD35400),
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
          color: seleccionado ? const Color(0xFFFCE4EC) : Colors.white,
          border: Border.all(
            color: seleccionado ? const Color(0xFFD35400) : Colors.grey.shade300,
            width: seleccionado ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            titulo,
            style: TextStyle(
              color: seleccionado ? const Color(0xFFD35400) : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}