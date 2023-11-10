import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_simple_channel_platform_interface.dart';

/// An implementation of [FlutterSimpleChannelPlatform] that uses method channels.
class MethodChannelFlutterSimpleChannel extends FlutterSimpleChannelPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_simple_channel');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
