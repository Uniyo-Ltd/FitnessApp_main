import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/providers/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late WorkoutProvider workoutProvider;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    workoutProvider = WorkoutProvider(prefs: prefs);
  });

  testWidgets('Adding a workout updates WorkoutListScreen',
      (WidgetTester tester) async {
    // Build the app with WorkoutScreen as the initial route
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: workoutProvider,
        child:
            MaterialApp(home: MyApp(prefs: prefs)), // Use your main app widget
      ),
    );

    // Find the "Add Set" button and tap it
    await tester.tap(find.byKey(const Key('addWorkoutButton')));

    try {
      await tester.pumpAndSettle(); // Wait for navigation and animations
      // Verify that the workout is displayed on the WorkoutListScreen
      expect(find.text('Bench Press'), findsOneWidget);

      print('Workout added successfully');
    } catch (e) {
      print('Error adding workout: $e');
      fail('Failed to add workout due to an error');
    }
  });
}
