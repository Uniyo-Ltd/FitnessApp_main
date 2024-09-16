import 'dart:math';

import 'package:fitnessapp/providers/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/workout_model.dart';

class EditWorkoutScreen extends StatefulWidget {
  final String workoutId;

  const EditWorkoutScreen({Key? key, required this.workoutId}) : super(key: key);

  @override
  _EditWorkoutScreenState createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
  final TextEditingController _weightController = TextEditingController();
  String? _selectedExercise;
  int _repetitions = 10;
  List<Set> sets = [];

  @override
  void initState() {
    super.initState();
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    final workout = workoutProvider.workouts.singleWhere((w) => w.id == widget.workoutId);
    _weightController.text = workout.weight.toString();
    _selectedExercise = workout.exercise;
    sets = workout.sets!.map((set) => Set(exercise: set.exercise, weight: set.weight, repetitions: set.repetitions)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Workout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                value: _selectedExercise,
                items: ['Barbell row', 'Bench press', 'Shoulder press', 'Deadlift', 'Squat']
                  .map((String item) => DropdownMenuItem<String>(value: item, child: Text(item)))
                  .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedExercise = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || double.tryParse(value) == null) {
                    return 'Please enter a valid weight';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Text('Repetitions')),
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        _repetitions = max(_repetitions - 1, 1);
                      });
                    },
                  ),
                  Text(_repetitions.toString()),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        _repetitions++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_weightController.text.isNotEmpty &&
                      _selectedExercise != null &&
                      _repetitions > 0) {
                    sets.add(Set(exercise: _selectedExercise!, weight: double.parse(_weightController.text), repetitions: _repetitions));
                    _weightController.clear();
                    _selectedExercise = null;
                    _repetitions = 10;
                  }
                },
                child: Text('Add Set'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  workoutProvider.updateWorkout(widget.workoutId, exercise: _selectedExercise!, weight: double.parse(_weightController.text), sets: sets);
                  Navigator.pop(context);
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}