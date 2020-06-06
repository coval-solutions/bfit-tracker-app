import 'package:bfit_tracker/models/user.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoRepository {
  final _userInfoCollection = Firestore.instance.collection('UserInfo');

  Stream<UserInfo> retrieve(User user) {
    return _userInfoCollection
        .document(user.getUid())
        .snapshots()
        .map(UserInfo().fromSnapshot);
  }

  Future<void> create(User user, UserInfo userInfo) async {
    return await _userInfoCollection
        .document(user.getUid())
        .setData(userInfo.toDocument());
  }

  Future<void> update(User user, UserInfo userInfo) async {
    return await _userInfoCollection
        .document(user.getUid())
        .updateData(userInfo.toDocument());
  }
}
