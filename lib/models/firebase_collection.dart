import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollection {
  final String _docRef;

  String get docRef => _docRef;

  FirebaseCollection(this._docRef);

  FirebaseCollection fromSnapshot(DocumentSnapshot snapshot) {
    return FirebaseCollection(snapshot.reference.id);
  }
}
