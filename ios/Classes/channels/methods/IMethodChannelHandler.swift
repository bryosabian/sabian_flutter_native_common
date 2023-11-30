//
//  IMethodChannelHandler.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation

protocol IMethodChannelHandler : AnyObject {
    func execute(payload: MethodChannelPayload)
}
