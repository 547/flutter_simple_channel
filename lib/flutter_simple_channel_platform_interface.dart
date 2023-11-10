import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_simple_channel_method_channel.dart';

abstract class FlutterSimpleChannelPlatform extends PlatformInterface {
  /// Constructs a FlutterSimpleChannelPlatform.
  FlutterSimpleChannelPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSimpleChannelPlatform _instance = MethodChannelFlutterSimpleChannel();

  /// The default instance of [FlutterSimpleChannelPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSimpleChannel].
  static FlutterSimpleChannelPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSimpleChannelPlatform] when
  /// they register themselves.
  static set instance(FlutterSimpleChannelPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
