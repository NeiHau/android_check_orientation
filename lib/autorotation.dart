import 'package:flutter/services.dart';

class AutoRotation {
  static const MethodChannel _channel = MethodChannel('auto_rotation');

  static Future<int> autoRotation() async {
    var autoRotation = await _channel.invokeMethod('getAutoRotation');

    return autoRotation != null ? int.parse(autoRotation) : 0;
  }
}
