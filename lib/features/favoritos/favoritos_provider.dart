import 'package:flutter/foundation.dart';

class FavoritosProvider with ChangeNotifier {
  final Set<String> _idsFavoritos = {};

  Set<String> get idsFavoritos => _idsFavoritos;

  bool esFavorito(String id) {
    return _idsFavoritos.contains(id);
  }

  void agregarFavorito(String id) {
    _idsFavoritos.add(id);
    notifyListeners();
  }

  void quitarFavorito(String id) {
    _idsFavoritos.remove(id);
    notifyListeners();
  }

  void toggleFavorito(String id) {
    if (_idsFavoritos.contains(id)) {
      _idsFavoritos.remove(id);
    } else {
      _idsFavoritos.add(id);
    }
    notifyListeners();
  }
}
