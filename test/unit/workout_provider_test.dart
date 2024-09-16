import 'package:fitnessapp/providers/workout_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late WorkoutProvider workoutProvider;

  setUp(() async {
    // Initialize SharedPreferences for testing
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    workoutProvider = WorkoutProvider(prefs: prefs);
  });

  group('WorkoutProvider Tests', () {
    test('Add a workout', () async {
      workoutProvider.addSet(
        exercise: 'Bench Press',
        weight: 50.0,
        repetitions: 10,
      );
      expect(workoutProvider.workouts.length, 1);
      expect(workoutProvider.workouts[0].exercise, 'Bench Press');
    });

    test('Remove a workout', () async {
      workoutProvider.addSet(
        exercise: 'Bench Press',
        weight: 50.0,
        repetitions: 10,
      );
      workoutProvider.removeWorkout(0);
      expect(workoutProvider.workouts.length, 0);
    });

    // Add more tests for other methods in WorkoutProvider (e.g., updateWorkout)
  });
}
