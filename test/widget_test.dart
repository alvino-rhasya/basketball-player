import 'package:flutter_test/flutter_test.dart';
import 'package:basketball_skl1/main.dart';

void main() {
  testWidgets('Basketball Players app basic flow and navigation test',
      (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const BasketballApp());
    await tester.pumpAndSettle();

    // Verify main list screen renders
    expect(find.text('Basketball Players'), findsOneWidget);
    expect(find.text('Anthony Edwards'), findsOneWidget);
    expect(find.text('Shooting Guard'), findsWidgets);

    // Tap on first player (Anthony Edwards) to navigate to detail
    await tester.tap(find.text('Anthony Edwards'));
    await tester.pumpAndSettle();

    // Verify detail screen content
    expect(find.text('Base Power : 92'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Stats'), findsOneWidget);
    expect(find.text('Skills'), findsOneWidget);
    expect(find.text('Scoring'), findsOneWidget);
    expect(find.text('Athleticism'), findsOneWidget);

    // Tap back button
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    // Verify back on main list
    expect(find.text('Basketball Players'), findsOneWidget);
  });

  testWidgets('Favorite button toggles favorite state',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BasketballApp());
    await tester.pumpAndSettle();

    // Verify Anthony Edwards favorite button can be tapped
    final favoriteFinder = find.byTooltip('Add to Favorites').first;
    await tester.tap(favoriteFinder);
    await tester.pumpAndSettle();

    // Now it should have changed to 'Remove from Favorites'
    expect(find.byTooltip('Remove from Favorites'), findsWidgets);
  });
}
