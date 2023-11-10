import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_channel/untils/logger.dart';

import 'flutter_simple_channel_platform_interface.dart';

/// An implementation of [FlutterSimpleChannelPlatform] that uses method channels.
class MethodChannelFlutterSimpleChannel extends FlutterSimpleChannelPlatform {
  static const channelNameForSendDataToNative =
      'com.seven.user.flutter_simple_channel.to.native';
  static const channelNameForSendDataToNativeMethod = 'sendDataToNative';
  static const channelNameForToken =
      'com.seven.user.flutter_simple_channel.token';
  static const channelNameForTokenMethod = 'updateWithUserToken';

  static const channelNameForData =
      'com.seven.user.flutter_simple_channel.data';
  static const channelNameForDataMethod = 'transmitData';

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(channelNameForSendDataToNative);
  @visibleForTesting
  final methodChannelForToken = const MethodChannel(
    MethodChannelFlutterSimpleChannel.channelNameForToken,
  );
  @visibleForTesting
  final methodChannelForDatas = const MethodChannel(
    MethodChannelFlutterSimpleChannel.channelNameForData,
  );

  MethodChannelFlutterSimpleChannel() {
    Logger.log("=========== 初始化Flutter user channel");
    methodChannelForToken.setMethodCallHandler(
      (call) async {
        Logger.log(
            "Native 调用 Flutter 成功，channel: ${methodChannelForToken.name} 方法：${call.method} 参数是：${call.arguments}");
        dynamic result;
        final method = call.method;
        switch (method) {
          case MethodChannelFlutterSimpleChannel.channelNameForTokenMethod:
            final token = call.arguments["token"];
            if (updateUserToken != null) {
              result = await updateUserToken?.call(token);
            } else {
              result = "flutter暂未接收$method方法参数";
            }
            break;
          default:
            result = FlutterError("方法名错误");
            break;
        }
        return result;
      },
    );
    methodChannelForDatas.setMethodCallHandler(
      (call) async {
        Logger.log(
            "Native 调用 Flutter 成功，channel: ${methodChannelForDatas.name} 方法：${call.method} 参数是：${call.arguments}");
        dynamic result;
        final method = call.method;
        switch (method) {
          case MethodChannelFlutterSimpleChannel.channelNameForDataMethod:
            final info = call.arguments["info"];
            if (transmitData != null) {
              result = await transmitData?.call(info);
            } else {
              result = "flutter暂未接收$method方法参数";
            }
            break;
          default:
            result = FlutterError("方法名错误");
            break;
        }
        return result;
      },
    );
  }
  @override
  Future<String?> getNativeVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getNativeVersion');
    return version;
  }

  @override
  Future<dynamic> sendDataToNative(Map<String, dynamic> arguments) async {
    var completer = Completer<dynamic>();
    methodChannel
        .invokeMethod<String>(
      MethodChannelFlutterSimpleChannel.channelNameForSendDataToNativeMethod,
      arguments,
    )
        .then((value) {
      completer.complete(value);
    }).catchError((onError) {
      completer.completeError(onError);
    });
    return completer.future;
  }

  @override
  void listenUserToken(
      Future<dynamic> Function(String? value) updateUserToken) {
    this.updateUserToken = updateUserToken;
  }

  @override
  void listenNativeData(Future Function(dynamic value) transmitData) {
    this.transmitData = transmitData;
  }
}
