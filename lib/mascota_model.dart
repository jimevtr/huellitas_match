class Mascota {
  final String id;
  final String nombre;
  final String especie;
  final int edad;
  final String tamano;
  final String rutaImagen;
  final String descripcion;
  final String actividad;
  final String espacio;
  final String tiempoCuidados;
  final String experiencia;

  const Mascota({
    required this.id,
    required this.nombre,
    required this.especie,
    required this.edad,
    required this.tamano,
    required this.rutaImagen,
    required this.descripcion,
    required this.actividad,
    required this.espacio,
    required this.tiempoCuidados,
    this.experiencia = 'basica',
  });
}
