// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:edamam/card.dart';
import 'package:edamam/scrollpagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:edamam/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("test end to end", () {
    testWidgets('Home Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.

      app.main();
      await tester.pumpAndSettle();
      //EXISTE LOGOTIPO:
      final imgFinder = find.image(Image.asset("images/icon.png").image);
      expect(imgFinder, findsOneWidget);
      //EXISTE BARRA DE BUSQUEDA:
      var searchFinder = find.text("Search");
      expect(searchFinder, findsOneWidget);
      //EXISTEN LETREROS:
      searchFinder = find.text("CALORIES");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("DIET");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("MEAL TYPE");
      expect(searchFinder, findsOneWidget);
      //CHIPS GENERADAS CORRECTAMENTE
      searchFinder = find.text("Balanced");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("High-Fiber");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("High-Protein");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("Low-Carb");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("Low-Fat");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("Low-Sodium");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("Breakfast");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("Lunch");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("Dinner");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("Snack");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("Teatime");
      expect(searchFinder, findsOneWidget);
      //CHECK VALUES OF SLIDER:
      searchFinder = find.text("500.0");
      expect(searchFinder, findsOneWidget);
      searchFinder = find.text("1500.0");
      expect(searchFinder, findsOneWidget);
    });

    testWidgets('Funcionalidades', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final searchButtonFinder = find.byIcon(Icons.search_rounded);
      expect(searchButtonFinder, findsOneWidget);
      final searchFieldFinder = find.byType(TextFormField);
      expect(searchFieldFinder, findsOneWidget);
      await tester.tap(searchFieldFinder); //Hacemos un tap al buscador.
      await tester.pumpAndSettle();
      await tester.enterText(searchFieldFinder, "patata"); //Escribimos "patata"
      await tester.pumpAndSettle();
      await tester.tap(searchButtonFinder); //Tap al boton de buscar
      await tester.pumpAndSettle();
      expect(find.byType(AppBar),
          findsOneWidget); //Comprobamos los widgets de Resultados()
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      final cardFinder = find.byType(CardRecipe);
      expect(cardFinder, findsWidgets);

      await tester.tap(cardFinder.first); //Hacemos un tap a la primera receta
      await tester.pumpAndSettle();

      final titleFinder = find.text(
          "Patatas Bravas"); //Comprobamos que la página contiene lo que debe.
      expect(titleFinder, findsOneWidget);
      expect(find.text("CALORIES"), findsOneWidget);
      expect(find.text("DIET"), findsOneWidget);
      expect(find.text("MEAL TYPE"), findsOneWidget);
      expect(find.text("EMISIONS"), findsOneWidget);
      expect(find.text("1149"), findsOneWidget);
      expect(find.text("High-Fiber"), findsOneWidget);
      expect(find.text("lunch/dinner"), findsOneWidget);
      expect(find.text("3211"), findsOneWidget);
      expect(find.text("INGRIDIENTS"), findsOneWidget);
    });
  });
}
