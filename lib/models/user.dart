import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;
  final String displayName;
  final NetworkImage displayPicture;

  User(this.id, this.email, this.displayName, this.displayPicture);

  static NetworkImage getImageFromUrl(String url) {
    return NetworkImage(url);
  }

  String getName() {
    return displayName;
  }

  String getForename() {
    return displayName.split(" ")[0];
  }
}