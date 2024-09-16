import 'package:fitnessapp/providers/workout_provider.dart';
import 'package:fitnessapp/view/edit_workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    print(
        'Building WorkoutListScreen with ${workoutProvider.workouts.length} workouts'); // Debug log

    return Scaffold(
      appBar: AppBar(title: Text('Workout List')),
      body: Consumer<WorkoutProvider>(
        builder: (context, workoutProvider, child) {
          return ListView.builder(
            itemCount: workoutProvider.workouts.length,
            itemBuilder: (context, index) {
              final workout = workoutProvider.workouts[index];
              return ListTile(
                title: Text(workout.exercise ?? '',
                    style: TextStyle(color: workout.textColor ?? Colors.black)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min, // To keep the Row compact
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditWorkoutScreen(
                              workoutId: workout.id ?? '',
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        workoutProvider.removeWorkout(index);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
