import 'package:flutter/foundation.dart';

class EncuestaProvider with ChangeNotifier {
  String? _espacio;
  String? _tiempoCuidados;
  String? _actividad;
  String? _experiencia;
  String? _tamanoPreferido;

  String? get espacio => _espacio;
  String? get tiempoCuidados => _tiempoCuidados;
  String? get actividad => _actividad;
  String? get experiencia => _experiencia;
  String? get tamanoPreferido => _tamanoPreferido;

  int get preguntasRespondidas {
    int count = 0;
    if (_espacio != null) count++;
    if (_tiempoCuidados != null) count++;
    if (_actividad != null) count++;
    if (_experiencia != null) count++;
    if (_tamanoPreferido != null) count++;
    return count;
  }

  bool get encuestaCompleta => preguntasRespondidas == 5;

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

  void setExperiencia(String valor) {
    _experiencia = valor;
    notifyListeners();
  }

  void setTamanoPreferido(String valor) {
    _tamanoPreferido = valor;
    notifyListeners();
  }

  void limpiarEncuesta() {
    _espacio = null;
    _tiempoCuidados = null;
    _actividad = null;
    _experiencia = null;
    _tamanoPreferido = null;
    notifyListeners();
  }
}
