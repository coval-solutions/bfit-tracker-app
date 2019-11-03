import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  static Future<DocumentSnapshot> read(String collectionDocumentPath) {
    return Firestore.instance.document(collectionDocumentPath).get();
  }
}