import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/workout_model.dart';

class WorkoutProvider with ChangeNotifier {
  List<Workout> _workouts = [];

  List<Set> sets = [];
  final SharedPreferences _prefs;
  List<Workout> get workouts => _workouts;

  WorkoutProvider({required SharedPreferences prefs}) : _prefs = prefs {
    _loadWorkouts();
  }

  void addSet(
      {required String exercise,
      required double weight,
      required int repetitions}) async {
    final workout = Workout(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      exercise: exercise,
      weight: weight,
      sets: [Set(exercise: exercise, weight: weight, repetitions: repetitions)],
      textColor: getRandomColor(), // Assign a random color
      repetitions: repetitions,
    );
    _workouts.add(workout);
    await _saveWorkouts();
    notifyListeners();
  }

  void saveWorkout(String name) async {
    final workout = Workout(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sets: sets,
      repetitions: 0,
    );
    _workouts.add(workout);
    await _saveWorkouts();
    sets.clear();
    notifyListeners();
  }

  Future<void> _saveWorkouts() async {
    final jsonList = _workouts.map((workout) => workout.toJson()).toList();
    await _prefs.setStringList(
        'workouts', json.encode(jsonList) as List<String>);
  }

  Future<void> _loadWorkouts() async {
    final jsonString = _prefs.getStringList('workouts');
    if (jsonString != null && jsonString.isNotEmpty) {
      final jsonList = json.decode(jsonString as String);
      _workouts = jsonList
          .map((json) =>
              Workout.fromJson(Map<String, dynamic>.from(json), json['_id']))
          .toList();
    }
  }

  Future<void> updateWorkout(String workoutId,
      {required String exercise,
      required double weight,
      required List<Set> sets}) async {
    final index = _workouts.indexWhere((workout) => workout.id == workoutId);
    if (index >= 0) {
      _workouts[index] = Workout(
        id: workoutId,
        exercise: exercise,
        weight: weight,
        sets: sets,
        textColor: Colors.black, repetitions: 0, // Add this line
      );
      notifyListeners();
    }
  }

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    print('Added workout: $workout'); // Debug log
    notifyListeners();
  }

  void removeWorkout(int index) {
    if (index >= 0 && index < _workouts.length) {
      _workouts.removeAt(index);
      _saveWorkouts();
      notifyListeners();
    }
  }
}

Color getRandomColor() {
  final random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1,
  );
}
