import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saas_flutter_plugin/saas_flutter_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('saas_flutter_plugin');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SaasFlutterPlugin.platformVersion, '42');
  });
}
