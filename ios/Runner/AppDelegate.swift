import Flutter
import UIKit
// import GoogleMaps                                          // Add this import


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
//      GMSServices.provideAPIKey("AIzaSyB_BCq0oZsuBcUYWs_yS2RlRaKTJL2-5XM")               // Add this line
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
