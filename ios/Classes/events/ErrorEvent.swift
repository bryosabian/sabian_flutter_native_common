//
//  ErrorEvent.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation
class ErrorEvent : AbstractMappableEvent<SabianError> {
    static let shared = ErrorEvent()
}
