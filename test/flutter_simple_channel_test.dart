import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_simple_channel/flutter_simple_channel.dart';
import 'package:flutter_simple_channel/flutter_simple_channel_platform_interface.dart';
import 'package:flutter_simple_channel/flutter_simple_channel_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSimpleChannelPlatform
    with MockPlatformInterfaceMixin
    implements FlutterSimpleChannelPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterSimpleChannelPlatform initialPlatform = FlutterSimpleChannelPlatform.instance;

  test('$MethodChannelFlutterSimpleChannel is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSimpleChannel>());
  });

  test('getPlatformVersion', () async {
    FlutterSimpleChannel flutterSimpleChannelPlugin = FlutterSimpleChannel();
    MockFlutterSimpleChannelPlatform fakePlatform = MockFlutterSimpleChannelPlatform();
    FlutterSimpleChannelPlatform.instance = fakePlatform;

    expect(await flutterSimpleChannelPlugin.getPlatformVersion(), '42');
  });
}
