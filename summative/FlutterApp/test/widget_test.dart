import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Correct import path

void main() {
  testWidgets('WildlifePredictor App widget test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(WildlifePredictorApp() as Widget);

    // Verify that the "Wildlife Predictor" title is displayed.
    expect(find.text('Wildlife Predictor'), findsOneWidget);

    // Verify that the input fields for animal population and habitat area are present.
    expect(find.byType(TextField),
        findsNWidgets(2)); // Two text fields for population and habitat area

    // Verify that the "Predict Score" button is displayed.
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verify that the initial prediction result text is not present yet.
    expect(find.text('Predicted Conservation Score:'), findsNothing);
    expect(find.text('Please enter valid numbers.'), findsNothing);

    // Tap the "Predict Score" button without entering any values
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Rebuild the widget after the tap

    // Verify that the prediction result shows the "Please enter valid numbers." message
    expect(find.text('Please enter valid numbers.'), findsOneWidget);

    // Enter valid values in the text fields.
    await tester.enterText(
        find.byType(TextField).at(0), '500'); // Enter population
    await tester.enterText(
        find.byType(TextField).at(1), '300'); // Enter habitat area

    // Tap the "Predict Score" button again with valid input
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Rebuild the widget after the tap

    // Verify that the prediction result is displayed.
    expect(find.text('Predicted Conservation Score:'), findsOneWidget);
    expect(find.textContaining('Predicted Conservation Score:'),
        findsOneWidget); // Checks if the score is displayed
  });
}

class WildlifePredictorApp {}
