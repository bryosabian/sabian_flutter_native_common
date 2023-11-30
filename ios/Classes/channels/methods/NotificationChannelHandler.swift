//
//  NotificationChannelHandler.swift
//  Runner
//
//  Created by Sweet Pea on 23/11/2023.
//

import Foundation


class NotificationChannelHandler : AbstractMethodChannelHandler {
    override func register() {
        register("postNotification", NotificationMethodChannelHandler())
    }

}
