import 'package:bfit_tracker/models/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleRepository {
  final _articleCollection = FirebaseFirestore.instance.collection('Articles');

  Stream<List<Article>> retrieveLatest() {
    return _articleCollection.limit(1).snapshots().map((event) =>
        event.docs.map((e) => Article(e.id).fromSnapshot(e)).toList());
  }

  Stream<List<Article>> retrieveAll() {
    return _articleCollection.snapshots().map((event) =>
        event.docs.map((e) => Article(e.id).fromSnapshot(e)).toList());
  }
}
