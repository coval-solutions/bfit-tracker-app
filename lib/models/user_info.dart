import 'package:bfit_tracker/models/goal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  final int height;
  final bool isMale;
  final Goal goals;

  UserInfo({this.height, this.isMale, this.goals});

  UserInfo fromSnapshot(DocumentSnapshot snapshot) {
    return UserInfo(
      height: snapshot.data['height'],
      isMale: snapshot.data['isMale'],
      goals: Goal.fromJson(snapshot.data['goals'])
    );
  }

  Map<String, Object> toDocument() =>
  {
    'height': height,
    'isMale': isMale,
    'goals': goals.toDocument()
  };
}