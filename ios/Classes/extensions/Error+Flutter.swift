//
//  Error+Flutter.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation
import Flutter

extension Error {
    var toFlutterError : FlutterError {
        get{
            return FlutterError(code: "Error", message: localizedDescription, details: nil)
        }
    }
}
