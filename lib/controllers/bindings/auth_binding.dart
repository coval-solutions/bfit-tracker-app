import 'package:bfit_tracker/controllers/auth_controller.dart';
import 'package:bfit_tracker/controllers/user_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<UserController>(() => UserController());
  }
}
