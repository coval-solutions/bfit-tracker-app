import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  static Future<DocumentSnapshot> read(String collectionDocumentPath) {
    return Firestore.instance.document(collectionDocumentPath).get();
  }

  static Future<void> create(String collectionDocumentPath, Map<String, dynamic> data) {
    return Firestore.instance.document(collectionDocumentPath).setData(data);
  }
}