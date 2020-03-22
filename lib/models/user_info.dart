import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  final int height;
  final bool isMale;

  UserInfo({this.height, this.isMale});

  UserInfo fromSnapshot(DocumentSnapshot snapshot) {
    return UserInfo(
      height: snapshot.data['height'],
      isMale: snapshot.data['isMale']
    );
  }

  Map<String, Object> toDocument() =>
  {
    'height': height,
    'isMale': isMale,
  };
}