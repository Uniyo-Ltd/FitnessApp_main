import 'dart:math';

import 'package:fitnessapp/providers/workout_provider.dart';
import 'package:fitnessapp/view/workout_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/workout_model.dart';

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final TextEditingController _weightController = TextEditingController();
  String? _selectedExercise;
  int _repetitions = 10;

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Add Workout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                key: const Key('addWorkoutButton'), 
                onPressed: () {
                  if (_weightController.text.isNotEmpty &&
                      _selectedExercise != null &&
                      _repetitions > 0) {
                    workoutProvider.addSet(
                      exercise: _selectedExercise!,
                      weight: double.parse(_weightController.text),
                      repetitions: _repetitions,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WorkoutListScreen()),
                    );
                  }
                },
                child: Text('Add Set'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}