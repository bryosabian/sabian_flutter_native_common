//
//  MethodChannelPayload.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation
import Flutter

class MethodChannelPayload {
    weak var controller: UIViewController?
    let result: FlutterResult
    let call : FlutterMethodCall
    
    init(controller: UIViewController, result: @escaping FlutterResult, call: FlutterMethodCall) {
        self.controller = controller
        self.result = result
        self.call = call
    }
}
