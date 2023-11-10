import Flutter
import UIKit

public class FlutterSimpleChannel: NSObject, FlutterPlugin {
  static let channelName =
      "com.seven.user.flutter_simple_channel";
  static let sendDataToNativeMethod = "sendDataToNative";
  static let updateWithUserTokenFromNativeMethod = "updateWithUserToken";
  static let transmitDataFromNativeMethod = "transmitData";

  public static let share = FlutterSimpleChannel()
    
  private var tokenChannel: FlutterMethodChannel?
  private var dataChannel: FlutterMethodChannel?
  private override init() {
    super.init()
  }
  public static func register(with registrar: FlutterPluginRegistrar) -> FlutterSimpleChannel {
    let channel = FlutterMethodChannel(name: FlutterSimpleChannel.channelName, binaryMessenger: registrar.messenger())
    let instance = FlutterSimpleChannel.share
    registrar.addMethodCallDelegate(instance, channel: channel)
    return instance
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
  public static func updateUserToken(with token: String?, engine: FlutterEngine, callback: @escaping (Any?) -> ()) {
    if share.tokenChannel == nil {
        // 创建渠道
        share.tokenChannel = FlutterMethodChannel(name: tokenChannelName, binaryMessenger: engine.binaryMessenger)
    }
        
    // 通过渠道调用 Flutter 的方法
    let params: Dictionary<String, String> = ["token": token ?? ""]
    share.tokenChannel?.invokeMethod(tokenChannelMethod, arguments: params) { result in
      callback(result)
    }
  }
    /// 传递其他信息
  public static func transmitOtherInfo(with info: [String : Any], engine: FlutterEngine, callback: @escaping (Any?) -> ()) {
    if share.otherInfoChannel == nil {
      // 创建渠道
      share.otherInfoChannel = FlutterMethodChannel(name: otherInfoChannelName, binaryMessenger: engine.binaryMessenger)
    }
    // 通过渠道调用 Flutter 的方法
    let params = ["info": info]
      share.otherInfoChannel?.invokeMethod(otherInfoChannelMethod, arguments: params) { result in
      callback(result)
    }
  }
}
