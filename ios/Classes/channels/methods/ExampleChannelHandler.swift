//
//  ExampleChannelHandler.swift
//  sabian_native_common
//
//  Created by Sweet Pea on 30/11/2023.
//

import Foundation

class ExampleChannelHandler : AbstractMethodChannelHandler {
    override func register() {
        register("getPlatformVersion", ExampleMethodChannelHandler())
    }
}

class ExampleMethodChannelHandler : IMethodChannelHandler {
    func execute(payload: MethodChannelPayload) {
        payload.result("iOS " + UIDevice.current.systemVersion)
    }
}
