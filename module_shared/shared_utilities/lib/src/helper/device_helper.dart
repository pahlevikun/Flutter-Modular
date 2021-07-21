import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceHelper {
  static Future<AndroidDeviceInfo> getAndroidDeviceInfo() async {
    return await DeviceInfoPlugin().androidInfo;
  }

  static bool isIosBuild(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS;
  }

  static bool isAndroidBuild(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.android;
  }
}
