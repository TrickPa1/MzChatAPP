import Flutter
import UIKit

//adicionei
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //adicionei
    FlutterLocalNotificationPlugin.setPluginRegistrationCallBack { (registry) in
    GeneratedPluginRegistrant.register(with: registry)}

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  
    //adicionei
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
