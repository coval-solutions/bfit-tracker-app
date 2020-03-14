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

  Future<UserInfo> _fetch(User user) async {
    final result = await FirestoreRepository.read("${UserInfoRepository.COLLECTION_NAME}/${user.id}");
    if (result.data == null) {
      return null;
    }

    final userInfo = UserInfo.fromJson(result.data);
    UserInfoRepository._userInfo = userInfo;
    return userInfo;
  }

  Future<UserInfo> _set(User user, UserInfoRepository userInfoRepository) async {
    final result = await FirestoreRepository.read("${UserInfoRepository.COLLECTION_NAME}/${user.id}");
    final userInfo = UserInfo.fromJson(result.data);

    UserInfoRepository._userInfo = userInfo;
    return userInfo;
  }
}