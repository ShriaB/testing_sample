import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_sample/models/favorites.dart';
import 'package:testing_sample/screens/home.dart';

Widget createHomeScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );

void main() {
  group("Home Page Widget Tests", () {
    testWidgets("Home Page should have a ListView", (WidgetTester) async {
      await WidgetTester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets("Home Page Should Scroll", (widgetTester) async {
      await widgetTester.pumpWidget(createHomeScreen());
      expect(find.text("Item 0"), findsOneWidget);
      await widgetTester.fling(find.byType(ListView), const Offset(0, -200),
          3000); // for scroll gesture
      await widgetTester.pumpAndSettle();
      expect(find.text("Item 0"), findsNothing);
    });

    testWidgets('Testing IconButtons', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byIcon(Icons.favorite), findsNothing);
      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Added to favorites.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsWidgets);
      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Removed from favorites.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}
