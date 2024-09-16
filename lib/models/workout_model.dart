import 'dart:ui';

class Workout {
  String? id;
  String? exercise;
  double? weight;
  List<Set>? sets;
  Color? textColor;
  int? repetitions;


  Workout({this.id, this.exercise, this.weight, this.sets, this.textColor, required int repetitions});

  Workout.fromJson(Map<String, dynamic> json, this.id) {
    exercise = json['exercise'];
    weight = json['weight'].toDouble();
    sets = (json['sets'] as List)
        .map((setJson) => Set.fromJson(setJson))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exercise': exercise,
      'weight': weight,
      'sets': sets?.map((set) => set.toJson()).toList(),
    };
  }
}

class Set {
  String? exercise;
  double? weight;
  int? repetitions;

  Set({this.exercise, this.weight, this.repetitions});

  Set.fromJson(Map<String, dynamic> json) {
    exercise = json['exercise'];
    weight = json['weight'].toDouble();
    repetitions = json['repetitions'];
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise': exercise,
      'weight': weight,
      'repetitions': repetitions,
    };
  }
}