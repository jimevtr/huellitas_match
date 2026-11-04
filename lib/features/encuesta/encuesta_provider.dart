import 'package:flutter/foundation.dart';

class EncuestaProvider with ChangeNotifier {
  String? _espacio;         
  String? _tiempoCuidados; 
  String? _actividad;    
  String? _experiencia;  
  String? _tipoHogar;      

  String? get espacio => _espacio;
  String? get tiempoCuidados => _tiempoCuidados;
  String? get actividad => _actividad;
  String? get experiencia => _experiencia;
  String? get tipoHogar => _tipoHogar;

  bool get encuestaCompleta =>
      _espacio != null &&
      _tiempoCuidados != null &&
      _actividad != null &&
      _experiencia != null &&
      _tipoHogar != null;

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

  void setTipoHogar(String valor) {
    _tipoHogar = valor;
    notifyListeners();
  }

  void limpiarEncuesta() {
    _espacio = null;
    _tiempoCuidados = null;
    _actividad = null;
    _experiencia = null;
    _tipoHogar = null;
    notifyListeners();
  }
}