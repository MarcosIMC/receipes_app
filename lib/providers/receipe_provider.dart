import 'package:flutter/material.dart';
import 'package:receipes_app/models/receipe.dart';

class ReceipeProvider with ChangeNotifier{
  List<Receipe> _receipes = [];

  List<Receipe> get receipes => _receipes;

  void addReceipe(Receipe receipe) {
    _receipes.add(receipe);
    notifyListeners();
  }

  void deleteReceipe(String id) {
    _receipes.removeWhere((receip) => receip.id == id);
    notifyListeners();
  }

  void toggleFavourite(String id) {
    int receipeIndex = _receipes.indexWhere((receipe) => receipe.id == id);
    _receipes[receipeIndex].isFavorite = !_receipes[receipeIndex].isFavorite;
    notifyListeners();
  }

  List<Receipe> favoriteReceipe() {
    return _receipes.where((receipe) => receipe.isFavorite == true).toList();
  }

  List<Receipe> searchBy(String query) {
    return _receipes.where((receip) =>
      receip.title.toLowerCase().contains(query.toLowerCase())
          || receip.description.contains(query)
          || receip.ingredients.any((ingredient) => ingredient.toLowerCase().contains(query.toLowerCase()))
      ).toList();
  }
}