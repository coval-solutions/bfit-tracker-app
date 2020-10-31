import 'package:bfit_tracker/models/goal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  final int height;
  final bool isMale;
  final int gymTime;
  final Goal goals;
  Map<String, dynamic> workoutsComplete;

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

  setWorkoutsComplete(Map<String, dynamic> workoutsCompleted) {
    this.workoutsComplete = workoutsCompleted;
  }

  Map<String, Object> toDocument() => {
        'height': height,
        'isMale': isMale,
        'gymTime': gymTime,
        'goals': goals.toDocument(),
        'workoutsComplete': workoutsComplete,
      };
}
