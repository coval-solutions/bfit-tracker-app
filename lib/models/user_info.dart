import 'package:bfit_tracker/models/goal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  final int height;
  final bool isMale;
  final double gymTime;
  final Goal goals;
  final Map<String, dynamic> workoutsComplete;

  UserInfo(
      {this.height,
      this.isMale,
      this.gymTime,
      this.goals,
      this.workoutsComplete});

  UserInfo fromSnapshot(DocumentSnapshot snapshot) {
    return UserInfo(
      height: snapshot.data()['height'] ?? 175,
      isMale: snapshot.data()['isMale'] ?? false,
      gymTime: snapshot.data()['gymTime'] ?? 0,
      goals: Goal.fromJson(snapshot.data()['goals']),
      workoutsComplete: snapshot.data()['workoutsComplete'],
    );
  }

  Map<String, dynamic> getStats() {
    Map<String, dynamic> stats = new Map<String, dynamic>();
    stats['BMI Goal'] = this.goals.getBmi();
    stats['Weight Goal'] = this.goals.getWeight();
    stats['Workouts Total'] = this.goals.getCourses();
    stats['Daily Steps'] = this.goals.getSteps();

    this.workoutsComplete.forEach((key, value) {
      // If exercise is plural (i.e. ends with s, such as Biceps or Triceps)
      // then remove the last character to make it singular
      if (key.endsWith('s')) {
        key = key.substring(0, key.length - 1);
      }

      stats[key + ' exercises completed'] = value;
    });

    return stats;
  }

  Map<String, Object> toDocument() => {
        'height': height,
        'isMale': isMale,
        'gymTime': gymTime,
        'goals': goals.toDocument(),
        'workoutsComplete': workoutsComplete,
      };
}
