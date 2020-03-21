import 'package:flutter/material.dart';

class User {
  final String _uid;
  final String _email;
  final String _displayName;
  final NetworkImage _displayPicture;

  User(this._uid, this._email, this._displayName, this._displayPicture);

  static NetworkImage getImageFromUrl(String url) {
    return NetworkImage(url);
  }

  String getName() {
    return _displayName;
  }

  String getUid() {
    return _uid;
  }

  String getForename() {
    return _displayName.split(" ")[0];
  }
}
