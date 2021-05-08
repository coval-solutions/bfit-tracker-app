import 'dart:math';

import 'package:bfit_tracker/models/goal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  int height;
  int weight;
  bool isMale;
  Goal goals;
  final double gymTime;
  final Map<String, dynamic> workoutsComplete;
  final int totalWorkoutsCompleted;

  UserInfo({
    this.height = 170,
    this.weight = 70,
    this.isMale = true,
    this.goals,
    this.gymTime = 0,
    this.workoutsComplete,
    this.totalWorkoutsCompleted = 0,
  });

  UserInfo fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      return UserInfo(
        height: snapshot.data()['height'] ?? 170,
        weight: snapshot.data()['weight'] ?? 70,
        isMale: snapshot.data()['isMale'] ?? true,
        gymTime: snapshot.data()['gymTime'] ?? 0,
        goals: Goal.fromJson(snapshot.data()['goals']),
        workoutsComplete: snapshot.data()['workoutsComplete'],
        totalWorkoutsCompleted: snapshot.data()['totalWorkoutsCompleted'] ?? 0,
      );
    }

    return null;
  }

  Map<String, dynamic> getStats() {
    Map<String, dynamic> stats = new Map<String, dynamic>();
    stats['BMI Goal'] = this.goals.getBmi();
    stats['Weight Goal'] = this.goals.getWeight();
    stats['Workouts Total'] = this.goals.getCourses();
    stats['Daily Steps'] = this.goals.getSteps();

    if (this.workoutsComplete != null) {
      this.workoutsComplete.forEach((key, value) {
        // If exercise is plural (i.e. ends with s, such as Biceps or Triceps)
        // then remove the last character to make it singular
        if (key.endsWith('s')) {
          key = key.substring(0, key.length - 1);
        }

        stats[key + ' exercises completed'] = value;
      });
    }

    return stats;
  }

  Map<String, Object> toDocument() => {
        'height': height,
        'weight': weight,
        'isMale': isMale,
        'gymTime': gymTime,
        'goals': goals?.toDocument(),
        'workoutsComplete': workoutsComplete,
        'totalWorkoutsCompleted': totalWorkoutsCompleted,
      };

  double calculateBmi() {
    return this.weight / pow(this.height / 100, 2);
  }
}
