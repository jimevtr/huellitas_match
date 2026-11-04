import 'package:flutter/material.dart';

import 'mascota_card.dart';
import 'mascota_details_screen.dart';
import 'mascota_model.dart';
import 'mascota_repository.dart';
import 'catalogo_theme.dart';

class MascotaCatalogScreen extends StatefulWidget {
  final VoidCallback? abrirEncuesta;
  final VoidCallback? abrirFavoritos;
  final Widget Function(Mascota mascota)? construirFavorito;
  final Map<String, String> sugerencias;

  const MascotaCatalogScreen({
    super.key,
    this.abrirEncuesta,
    this.abrirFavoritos,
    this.construirFavorito,
    this.sugerencias = const {},
  });

  @override
  State<MascotaCatalogScreen> createState() => _MascotaCatalogScreenState();
}

class _MascotaCatalogScreenState extends State<MascotaCatalogScreen> {
  final buscador = TextEditingController();
  final mascotas = MascotaRepository().obtenerMascotas();
  String especie = 'Todos';
  String busqueda = '';

  List<Mascota> get mascotasFiltradas {
    final resultado = mascotas.where((mascota) {
      final coincideEspecie = especie == 'Todos' || mascota.especie == especie;
      final coincideNombre = mascota.nombre.toLowerCase().contains(
        busqueda.trim().toLowerCase(),
      );
      return coincideEspecie && coincideNombre;
    }).toList();
    if (widget.sugerencias.isNotEmpty) {
      return [
        ...resultado.where((m) => widget.sugerencias.containsKey(m.id)),
        ...resultado.where((m) => !widget.sugerencias.containsKey(m.id)),
      ];
    }
    return resultado;
  }

  @override
  void dispose() {
    buscador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lista = mascotasFiltradas;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tu próximo match',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UN MATCH PARA TODA LA VIDA',
                      style: const TextStyle(
                        fontSize: 10,
                        letterSpacing: 1,
                        color: CatalogoColors.terracota,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Encuentra una compañía que vaya a tu ritmo.',
                      style: const TextStyle(
                        fontSize: 12,
                        color: CatalogoColors.secundario,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: buscador,
                  decoration: InputDecoration(
                    hintText: 'Buscar por nombre...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: busqueda.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'Limpiar búsqueda',
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              buscador.clear();
                              setState(() => busqueda = '');
                            },
                          ),
                  ),
                  onChanged: (texto) => setState(() => busqueda = texto),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  children: ['Todos', 'Perro', 'Gato'].map((opcion) {
                    return ChoiceChip(
                      showCheckmark: false,
                      selectedColor: CatalogoColors.suave,
                      backgroundColor: const Color(0xFFF0ECE6),
                      side: BorderSide.none,
                      labelStyle: TextStyle(
                        color: especie == opcion
                            ? CatalogoColors.terracota
                            : CatalogoColors.secundario,
                      ),
                      label: Text(opcion == 'Todos' ? opcion : '${opcion}s'),
                      selected: especie == opcion,
                      onSelected: (_) => setState(() => especie = opcion),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.sugerencias.isEmpty
                            ? 'Conoce a las mascotas'
                            : 'Según tus respuestas',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      '${lista.length} mascotas',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: lista.isEmpty
                    ? const Center(
                        child: Text(
                          'No encontramos mascotas con esa búsqueda.',
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                        itemCount: lista.length,
                        itemBuilder: (context, index) {
                          final mascota = lista[index];
                          return MascotaCard(
                            mascota: mascota,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (_) => MascotaDetailsScreen(
                                  mascota: mascota,
                                  motivoSugerencia:
                                      widget.sugerencias[mascota.id],
                                  construirFavorito: widget.construirFavorito,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              if (widget.abrirEncuesta != null || widget.abrirFavoritos != null)
                SafeArea(
                  top: false,
                  child: OverflowBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (widget.abrirEncuesta != null)
                        TextButton.icon(
                          onPressed: widget.abrirEncuesta,
                          icon: const Icon(Icons.quiz_outlined),
                          label: const Text('Encuesta'),
                        ),
                      if (widget.abrirFavoritos != null)
                        TextButton.icon(
                          onPressed: widget.abrirFavoritos,
                          icon: const Icon(Icons.favorite_border),
                          label: const Text('Favoritos'),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
