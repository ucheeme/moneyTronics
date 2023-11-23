
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
// import 'AppUtils.dart';
import 'package:uuid/uuid.dart';

import 'appUtil.dart';

String deviceId = "";
String deviceName = "";
String platformOS = "";
String deviceModel = "";
String deviceOs = "";
String deviceOs2 = "";

 class DeviceUtils{
  static  var uuid = const Uuid();
    static initDeviceInfo() async {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        if (Platform.isAndroid) {
          AndroidDeviceInfo info = await deviceInfo.androidInfo;
          deviceId = info.id;
          deviceName = info.manufacturer;
          deviceModel = info.model;
          platformOS = "Android";
          deviceOs = "Android";
          AppUtils.debug("platform is Android");
        } else if (Platform.isIOS) {
          IosDeviceInfo info = await deviceInfo.iosInfo;
          deviceId = info.identifierForVendor!;
          deviceName = info.name+"' "+info.utsname.machine;
          deviceModel = info.model;
          deviceOs = "iOS";
          platformOS = info.systemName+" "+info.systemVersion;
        }
      }
    initPackage() async {
    //PackageInfo packageInfo = await PackageInfo.fromPlatform();
    }
}