import 'flutter_simple_channel_platform_interface.dart';

class FlutterSimpleChannel {
  static Future<String?> getNativeVersion() {
    return FlutterSimpleChannelPlatform.instance.getNativeVersion();
  }

  static listenUserToken(Future<dynamic> Function(String?) updateUserToken) {
    FlutterSimpleChannelPlatform.instance.listenUserToken(updateUserToken);
  }

  static listenNativeDatas(Future<dynamic> Function(dynamic) transmitData) {
    FlutterSimpleChannelPlatform.instance.listenNativeData(transmitData);
  }
}
