//
//  EventChannelHandler.swift
//  Runner
//
//  Created by bryosabian on 22/11/2023.
//

import Foundation
import Flutter

class EventChannelHandler : IChannelHandler<AbstractEvent, EventChannelPayload> {
    
    override func register() {
        register("com.sabian_common_native.events.loader", LoaderEvent.shared)
        register("com.sabian_common_native.events.error", ErrorEvent.shared)
    }
    
    override func create(_ key: String, payload : ChannelPayload) {
        super.create(key, payload: payload)
        self.map.forEach({ [unowned self] key,value in
            self.execute(value, EventChannelPayload(channelName: key,messenger: payload.messengaer))
        })
    }
    
    

    override func execute(_ action: AbstractEvent, _ args: EventChannelPayload) {
        print("sabian_native : Executing event for \(args.channelName)")
        FlutterEventChannel(name: args.channelName, binaryMessenger: args.messenger).setStreamHandler(action)
    }
}
