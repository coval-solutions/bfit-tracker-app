import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String docRef;
  final String title;
  final String subtitle;
  final String author;
  final String imageUrl;
  final String textUrl;
  final int minsToRead;

  Article(
    this.docRef, {
    this.title,
    this.subtitle,
    this.author,
    this.imageUrl,
    this.textUrl,
    this.minsToRead,
  });

  Article fromSnapshot(DocumentSnapshot snapshot) {
    return Article(
      docRef,
      title: snapshot.data()['title'] ?? '',
      subtitle: snapshot.data()['subtitle'] ?? '',
      author: snapshot.data()['author'] ?? '',
      imageUrl: snapshot.data()['image_url'] ?? '',
      textUrl: snapshot.data()['text_url'] ?? '',
      minsToRead: snapshot.data()['mins_to_read'] ?? 5,
    );
  }
}
