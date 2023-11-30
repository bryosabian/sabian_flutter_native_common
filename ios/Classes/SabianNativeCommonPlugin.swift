import Flutter
import UIKit

public class SabianNativeCommonPlugin: NSObject, FlutterPlugin {
    
  private static let manager = ChannelManager()
    
  public static func register(with registrar: FlutterPluginRegistrar) {
      manager.configure(payload: ChannelPayload(messengaer: registrar.messenger()))
  }
}
