import 'package:cached_network_image/cached_network_image.dart';

class CovalUser {
  final String _uid;
  final String _email;
  final String _displayName;
  final CachedNetworkImageProvider _displayPicture;

  CovalUser(this._uid, this._email, this._displayName, this._displayPicture);

  static CachedNetworkImageProvider getImageFromUrl(String url) {
    return CachedNetworkImageProvider(url);
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

  CachedNetworkImageProvider getDisplayPicture() {
    return _displayPicture;
  }

  String getEmail() {
    return _email;
  }
}
