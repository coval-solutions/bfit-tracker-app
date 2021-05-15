import 'package:bfit_tracker/controllers/navigation_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NavigationController>(NavigationController());
  }
}
