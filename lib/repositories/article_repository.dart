import 'package:bfit_tracker/models/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleRepository {
  final _articleCollection = FirebaseFirestore.instance.collection('Articles');

  Stream<List<Article>> retrieve() {
    return _articleCollection.snapshots().map(
        (event) => event.docs.map((e) => Article().fromSnapshot(e)).toList());
  }
}