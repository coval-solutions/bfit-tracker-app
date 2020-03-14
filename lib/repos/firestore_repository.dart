import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  static Future<DocumentSnapshot> read(String collectionDocumentPath) {
    return Firestore.instance.document(collectionDocumentPath).get();
  }

  static Future<DocumentSnapshot> create(String collectionDocumentPath) {
    return Firestore.instance.document(collectionDocumentPath).get();
  }
}