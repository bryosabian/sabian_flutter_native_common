//
//  ChannelManager.swift
//  Runner
//
//  Created by bryosabian on 23/11/2023.
//

import Foundation
import Flutter

class ChannelManager {
    
    private var methodChannelHandlers : Dictionary<String,AnyChannelHandler> = Dictionary()
    
    private var eventChannelHandlers : Dictionary<String,AnyChannelHandler> = Dictionary()
    
    
    private func initEvents(){
        eventChannelHandlers["com.sabian_common_native.events"] = EventChannelHandler()
    }
    
    private func initMethods(){
        methodChannelHandlers["com.sabian_common_native.methods.media"] = MediaChannelHandler()
        methodChannelHandlers["com.sabian_common_native.methods.notifications"] = NotificationChannelHandler()
        methodChannelHandlers["com.sabian_common_native.methods.device"] = DeviceChannelHandler()
    }
    
    private func configureEvents(payload : ChannelPayload){
        eventChannelHandlers.forEach({ key,value in
            value.create(key, payload: payload)
        })
    }
    
    private func configureMethods(payload : ChannelPayload){
        methodChannelHandlers.forEach({  key,value in
            value.create(key, payload: payload)
        })
    }
    
    func configure(payload : ChannelPayload){
        self.initEvents()
        self.initMethods()
        self.configureEvents(payload: payload)
        self.configureMethods(payload : payload)
    }
}
