import 'mascota_model.dart';

class MascotaRepository {
  List<Mascota> obtenerMascotas() => List.of(mascotasDemo);
}

// Datos e imágenes ficticios de demostración.
const mascotasDemo = [
  Mascota(
    id: 'demo-luna', nombre: 'Luna', especie: 'Perro', edad: 3,
    tamano: 'Mediano', rutaImagen: 'img/luna.png',
    descripcion: 'Ejemplo: mascota tranquila que necesita paseos diarios.',
    actividad: 'tranquila', espacio: 'pequeno', tiempoCuidados: 'moderado',
  ),
  Mascota(
    id: 'demo-milo', nombre: 'Milo', especie: 'Gato', edad: 2,
    tamano: 'Pequeno', rutaImagen: 'img/milo.png',
    descripcion: 'Ejemplo: gato activo que necesita juego diario.',
    actividad: 'activa', espacio: 'pequeno', tiempoCuidados: 'moderado',
  ),
];
