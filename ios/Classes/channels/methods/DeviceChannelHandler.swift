//
//  DeviceChannelHandler.swift
//  sabian_native_common
//
//  Created by bryosabian on 06/12/2023.
//

import Foundation

class DeviceChannelHandler : AbstractMethodChannelHandler {
    override func register() {
        register("getPlatformVersion", PlatformVersionMethod())
    }
}

private class PlatformVersionMethod : IMethodChannelHandler {
    func execute(payload: MethodChannelPayload) {
        payload.result("iOS " + UIDevice.current.systemVersion)
    }
}
