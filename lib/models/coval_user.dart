import 'package:bfit_tracker/models/user_info.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CovalUser {
  String uid;
  String email;
  String displayName;
  CachedNetworkImageProvider displayPicture;
  UserInfo userInfo;

  CovalUser(
      {this.uid,
      this.email,
      this.displayName,
      this.displayPicture,
      this.userInfo});

  // TODO: move this into the Utils class?
  static CachedNetworkImageProvider getImageFromUrl(String url) {
    return CachedNetworkImageProvider(url);
  }

  String getName() {
    return displayName;
  }

  String getUid() {
    return uid;
  }

  String getForename() {
    return displayName.split(" ")[0];
  }

  CachedNetworkImageProvider getDisplayPicture() {
    return displayPicture;
  }

  String getEmail() {
    return email;
  }

  void setUserInfo(UserInfo userInfo) {
    this.userInfo = userInfo;
  }
}
