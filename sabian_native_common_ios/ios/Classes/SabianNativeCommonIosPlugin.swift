import Flutter
import UIKit

public class SabianNativeCommonIosPlugin: NSObject, FlutterPlugin {
    private static let manager = ChannelManager()

    public static func register(with registrar: FlutterPluginRegistrar) {
        manager.configure(payload: ChannelPayload(messenger: registrar.messenger()))
    }
}
