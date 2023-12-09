//
//  IChannelHandler.swift
//  Runner
//
//  Created by bryosabian on 22/11/2023.
//

import Foundation
import Flutter

protocol AnyChannelHandler {
    func executeAny(_ action : Any, _ args : Any)
    func create(_ key: String, payload : ChannelPayload)
}

extension AnyChannelHandler{
    func executeAny(_ action : Any, _ args : Any){
       print("Any channel handler has not been implemented")
    }
}

class IChannelHandler<T : Any, A : Any> : AnyChannelHandler {
    
    var map : Dictionary<String,T> = Dictionary()
    
    var controller : UIViewController {
        get{
            return UIApplication.shared.keyWindow!.rootViewController!
        }
    }
    
    func register(_ channel: String, _ action: T) {
        map[channel] = action
    }
    
    func register() {
        print("'register' has not been implemented")
    }
    
    func create(_ key: String, payload : ChannelPayload) {
        register()
    }
    
    
    func execute(channelAction: String, args: A) {
        guard let action = map[channelAction] else {
            print("sabian_native_common : No call found for \(channelAction)")
            return
        }
        print("sabian_native_common : Executing for \(channelAction)")
        self.execute(action, args)
    }
    
    func execute(_ action: T, _ args: A) {
        print("'execute' has not been implemented")
    }
    
    func executeAny(_ action: Any, _ args: Any) {
        let mAction = action as! T
        let mPayload = args as! A
        self.execute(mAction,mPayload)
    }
    
}

