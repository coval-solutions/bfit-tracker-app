import 'package:get/get.dart';

class NavigationController extends GetxController {
  Rx<int> _index = Rx<int>(0);

  int get index => _index.value;

  set index(int value) => _index.value = value;
}
