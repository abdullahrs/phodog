import 'package:flutter/services.dart';

class PlatformInfoHelper {
  static const MethodChannel _methodChannel =
      MethodChannel('dev.flutter.deviceinfo/device_info');

  static PlatformInfoHelper instance = PlatformInfoHelper._();
  static PlatformInfoHelper? _instance;

  PlatformInfoHelper._internal();

  String? deviceVersion;

  factory PlatformInfoHelper._() {
    return _instance ??= PlatformInfoHelper._internal();
  }

  Future<String?> getDeviceVersion() async {
    try {
      final result = await _methodChannel.invokeMethod<String>('getDeviceVersion');
      deviceVersion = result;
      return result;
    } on PlatformException catch (e) {
      throw Exception("Failed to get device version: '${e.message}'.");
    }
  }
}