import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_simple_channel/flutter_simple_channel.dart';
import 'package:flutter_simple_channel/flutter_simple_channel_platform_interface.dart';
import 'package:flutter_simple_channel/flutter_simple_channel_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSimpleChannelPlatform
    with MockPlatformInterfaceMixin
    implements FlutterSimpleChannelPlatform {
  @override
  Future<String?> getNativeVersion() => Future.value('42');

  @override
  void listenNativeData(Future Function(dynamic value) transmitData) {
    this.transmitData = transmitData;
  }

  @override
  void listenUserToken(Future Function(String? value) updateUserToken) {
    this.updateUserToken = updateUserToken;
  }

  @override
  Future Function(dynamic value)? transmitData;

  @override
  Future Function(String? value)? updateUserToken;

  @override
  Future sendDataToNative(Map<String, dynamic> arguments) =>
      Future.value('get it');
}

void main() {
  final FlutterSimpleChannelPlatform initialPlatform =
      FlutterSimpleChannelPlatform.instance;

  test('$MethodChannelFlutterSimpleChannel is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSimpleChannel>());
  });

  test('getPlatformVersion', () async {
    MockFlutterSimpleChannelPlatform fakePlatform =
        MockFlutterSimpleChannelPlatform();
    FlutterSimpleChannelPlatform.instance = fakePlatform;

    expect(await FlutterSimpleChannel.getNativeVersion(), '42');
  });
}
