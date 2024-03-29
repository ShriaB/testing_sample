import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_sample/main.dart';

void main() {
  group("Testing App", () {
    testWidgets("Favorites Operations Test", (tester) async {
      await tester.pumpWidget(const TestingApp());
      final iconKeys = ["icon_0", "icon_1", "icon_2"];

      for (var icon in iconKeys) {
        await tester.tap(find.byKey(ValueKey(icon)));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text("Added to favorites."), findsOneWidget);
      }

      await tester.tap(find.text("Favorites"));
      await tester.pumpAndSettle();

      final removeIconKeys = [
        "remove_icon_0",
        "remove_icon_1",
        "remove_icon_2"
      ];

      for (var removeIcons in removeIconKeys) {
        await tester.tap(find.byKey(ValueKey(removeIcons)));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text("Removed from favorites."), findsOneWidget);
      }
    });
  });
}
