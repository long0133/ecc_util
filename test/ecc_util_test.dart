import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecc_util/ecc_util.dart';

void main() {
  const MethodChannel channel = MethodChannel('ecc_util');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await EccUtil.decrypt('42'), '42');
  });
}
