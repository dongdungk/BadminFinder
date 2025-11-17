import UIKit
import Flutter
import GoogleMaps // 1. 이 줄을 추가합니다.

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // 2. 이 줄을 추가합니다. (님이 주신 API 키)
    GMSServices.provideAPIKey("AIzaSyCqxzxXNOyTKdHHX-6EWtzYaypbdtaPfxM")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}