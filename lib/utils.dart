import 'dart:io' show Platform;
import 'dart:math';

import 'package:device_info/device_info.dart';
import 'package:get/get.dart';

class Utils {
  static final int heightBoundary = 640;
  static final int widthBoundary = 360;

  static final Random random = Random();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<bool> get isPhysicalDevice async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      return androidDeviceInfo.isPhysicalDevice;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      return iosDeviceInfo.isPhysicalDevice;
    } else {
      return false;
    }
  }

  static bool isSmallScreen() =>
      Get.height < heightBoundary || Get.width < widthBoundary;

  static double doubleInRange(int start, int end) =>
      random.nextDouble() * (end - start) + start;

  static String locale() => Platform.localeName;
}
