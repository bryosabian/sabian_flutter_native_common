//
//  NotificationChannelHandler.swift
//  Runner
//
//  Created by bryosabian on 23/11/2023.
//

import Foundation


class NotificationChannelHandler : AbstractMethodChannelHandler {
    override func register() {
        register("postNotification", NotificationMethodChannelHandler())
    }

}
