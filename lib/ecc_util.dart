
import 'dart:async';

import 'package:flutter/services.dart';

class EccUtil {
  static const MethodChannel _channel =
      const MethodChannel('ecc_util');

  static Future<String> encrypt(String text) async {
    final String encrypt = await _channel.invokeMethod('encrypt',text);
    return encrypt;
  }
  static Future<String> decrypt(String text) async {
    final String decrypt = await _channel.invokeMethod('decrypt',text);
    return decrypt;
  }
}
