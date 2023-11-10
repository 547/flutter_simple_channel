
import 'flutter_simple_channel_platform_interface.dart';

class FlutterSimpleChannel {
  Future<String?> getPlatformVersion() {
    return FlutterSimpleChannelPlatform.instance.getPlatformVersion();
  }
}
