//
//  AbstractMethodChannelHandler.swift
//  Runner
//
//  Created by bryosabian on 23/11/2023.
//

import Foundation
import Flutter

class AbstractMethodChannelHandler : IChannelHandler<IMethodChannelHandler, MethodChannelPayload> {
    
    override func execute(_ action: IMethodChannelHandler, _ args: MethodChannelPayload) {
        action.execute(payload: args)
    }
    
    override func create(_ key: String, payload : ChannelPayload) {
        
        super.create(key, payload: payload)
        
        let channel = FlutterMethodChannel(name: key, binaryMessenger: payload.messenger)
        
        channel.setMethodCallHandler({ [unowned self] call,result in
            self.execute(channelAction : call.method, args: MethodChannelPayload(controller: controller, result: result, call: call))
        })

    }
}
