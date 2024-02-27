import 'package:flutter_test/flutter_test.dart';
import 'package:testing_sample/models/favorites.dart';

void main() {
  group('App Provider Testing', () {
    var favorites = Favorites();

    test("A new item should be added", () {
      var number = 10;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
    });

    test("An item should be removed", () {
      var number = 11;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
      favorites.remove(number);
      expect(favorites.items.contains(number), false);
    });
  });
}
