import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;
  final String displayName;
  final String shortName;
  final NetworkImage displayPicture;

  User(this.id, this.email, this.displayName, this.shortName, this.displayPicture);

  static NetworkImage getImageFromUrl(String url) {
    return NetworkImage(url);
  }
}