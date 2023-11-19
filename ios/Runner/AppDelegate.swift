import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let deviceInfoChannel = FlutterMethodChannel(name: "dev.flutter.deviceinfo/device_info",
                                              binaryMessenger: controller.binaryMessenger)
    deviceInfoChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard call.method == "getDeviceVersion" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self.getDeviceVersion(result: result)
    })

      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    private func getDeviceVersion(result: FlutterResult) {
      let device = UIDevice.current
        let systemVersion = device.systemVersion
      return result(String(systemVersion))
    }
}
