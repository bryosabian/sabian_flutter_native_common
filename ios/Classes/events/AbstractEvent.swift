//
//  AbstractEvent.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation
import Flutter


class AbstractEvent : NSObject,FlutterStreamHandler {
    
    var eventSink: FlutterEventSink? = nil
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
   
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
    

    func raise(_ payload: Any) {
        if let sink = eventSink {
            sink(payload)
        }
    }
}
