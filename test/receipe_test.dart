import 'package:flutter_test/flutter_test.dart';
import 'package:receipes_app/models/receipe.dart';
import 'package:receipes_app/providers/receipe_provider.dart';

void main() {
  late ReceipeProvider provider;

  setUpAll(() {
    provider = ReceipeProvider();
  });

  group('Receipes should', () {
    test('Check if get a empty list when we not add any element', () {
      expect(provider.receipes.length, equals(0));
    });

    test('Add a new receip to list', () {
      provider.addReceipe(Receipe(id: '1', title: 'Spaguetti', description: 'Deliciosos spaguetti con un toque picante', ingredients: ['Spaguetti', 'Tomatto', 'Tuna'], imageUrl: '', isFavorite: false));
      expect(provider.receipes.length, equals(1));
    });

    test('Add to favourite our receip', () {
      provider.toggleFavourite(provider.receipes.first.id);
      expect(provider.receipes.first.isFavorite, equals(isTrue));
    });

    test('Detele a receip from receips list', () {
      provider.deleteReceipe(provider.receipes.first.id);
      expect(provider.receipes.length, equals(0));
    });
  });
}