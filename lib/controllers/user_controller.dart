import 'package:bfit_tracker/models/coval_user.dart';
import 'package:bfit_tracker/repositories/user_info_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  UserInfoRepository userInfoRepository = UserInfoRepository();
  Rx<CovalUser> _covalUser = CovalUser().obs;

  CovalUser get user => _covalUser.value;

  set user(CovalUser value) => this._covalUser.value = value;

  void setHeight(int height) {
    _covalUser.update((val) {
      print('Old: ' + val.userInfo.height.toString());
      val.userInfo.height = height;
      print('New: ' + val.userInfo.height.toString());
    });
  }

  void setIsMale(bool isMale) {
    _covalUser.update((val) {
      val.userInfo.isMale = isMale;
    });
  }

  void clear() {
    _covalUser.value = CovalUser();
  }
}
