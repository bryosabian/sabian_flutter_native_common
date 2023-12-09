//
//  NotificationContent.swift
//  Runner
//
//  Created by bryosabian on 23/11/2023.
//

import Foundation

struct NotificationContent {
    var ID : String? = nil
    var title : String!
    var subTitle : String? = nil
    var body : String? = nil
    var categoryID : String? = nil
    var sound : UNNotificationSound! = UNNotificationSound.default
}

extension NotificationContent {
    var toContent : UNMutableNotificationContent{
        get {
            
            let content = UNMutableNotificationContent()
            
            content.title = title
            
            if let subTitle = subTitle {
                content.subtitle = subTitle
            }
            
            if let body = body {
                content.body = body
            }
            
            content.sound = sound
            
            return content
        }
    }
}
