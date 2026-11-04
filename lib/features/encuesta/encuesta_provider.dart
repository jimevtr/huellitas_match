import 'package:flutter/foundation.dart';

class EncuestaProvider with ChangeNotifier {
  String? _espacio;         // 'pequeño' / 'amplio'
  String? _tiempoCuidados;  // 'moderado' / 'alto'
  String? _actividad;       // 'tranquila' / 'activa'

  String? get espacio => _espacio;
  String? get tiempoCuidados => _tiempoCuidados;
  String? get actividad => _actividad;

  bool get encuestaCompleta =>
      _espacio != null && _tiempoCuidados != null && _actividad != null;

  void setEspacio(String valor) {
    _espacio = valor;
    notifyListeners();
  }

  void setTiempoCuidados(String valor) {
    _tiempoCuidados = valor;
    notifyListeners();
  }

  void setActividad(String valor) {
    _actividad = valor;
    notifyListeners();
  }

  void limpiarEncuesta() {
    _espacio = null;
    _tiempoCuidados = null;
    _actividad = null;
    notifyListeners();
  }
}