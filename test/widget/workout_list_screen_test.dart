import 'package:fitnessapp/models/workout_model.dart';
import 'package:fitnessapp/providers/workout_provider.dart';
import 'package:fitnessapp/view/workout_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late WorkoutProvider workoutProvider;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    workoutProvider = WorkoutProvider(prefs: prefs);
  });

  group('WorkoutListScreen Tests', () {
    testWidgets('Displays workouts correctly', (WidgetTester tester) async {
      workoutProvider.addSet(
        exercise: 'Bench Press',
        weight: 50.0,
        repetitions: 10,
      );

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: workoutProvider,
          child: MaterialApp(home: WorkoutListScreen()),
        ),
      );

      expect(find.text('Bench Press'), findsOneWidget); // Check for workout name
      expect(find.byIcon(Icons.edit), findsOneWidget); // Check for edit icon
      expect(find.byIcon(Icons.delete), findsOneWidget); // Check for delete icon
    });

    // Add more tests for user interactions (e.g., tapping edit, tapping delete)
  });
}
