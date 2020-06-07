import 'dart:io' show Platform;
import 'dart:math';

import 'package:device_info/device_info.dart';

class Utils {
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

  static double doubleInRange(int start, int end) =>
      random.nextDouble() * (end - start) + start;

  static String locale() => Platform.localeName;
}
