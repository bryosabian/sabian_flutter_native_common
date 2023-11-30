//
//  FlutterCall+Sabian.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation
import Flutter

extension FlutterMethodCall {
    func argument<T : Any>(_ key : String) -> T? {
        if let args = arguments as? Dictionary<String, Any>,let value = args[key] as? T {
            print("Found argument variable from method")
            return value
        }
        print("No argument variable found from method")
        return nil
    }
}
