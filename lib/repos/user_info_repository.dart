import 'package:bfit_tracker/models/user.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/repos/firestore_repository.dart';
import 'package:bfit_tracker/repos/user_repository.dart';

class UserInfoRepository {
  static const String COLLECTION_NAME = 'UserInfo';
  static UserInfo _userInfo;

  UserInfoRepository();

  Future<UserInfo> getUserInfo() async {
    User user = UserRepository.getCurrentUser();
    if (user != null) {
      if (UserInfoRepository._userInfo != null) {
        return UserInfoRepository._userInfo;
      }

      return await this._fetch(user);
    }

    return null;
  }

  Future<void> setUserInfo(UserInfo userInfo) async {
    User user = UserRepository.getCurrentUser();
    if (user != null) {
      return this._set(user, userInfo);
    }

    return null;
  }

  Future<UserInfo> _fetch(User user) async {
    final result = await FirestoreRepository.read("${UserInfoRepository.COLLECTION_NAME}/${user.id}");
    if (result.data == null) {
      return null;
    }

    final userInfo = UserInfo.fromJson(result.data);
    UserInfoRepository._userInfo = userInfo;
    return userInfo;
  }

  Future<void> _set(User user, UserInfo data) async {
    await FirestoreRepository.create("${UserInfoRepository.COLLECTION_NAME}/${user.id}", data.toJson());
  }
}