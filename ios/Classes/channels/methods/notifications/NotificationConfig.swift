//
//  NotificationConfig.swift
//  Runner
//
//  Created by bryosabian on 23/11/2023.
//

import Foundation

struct NotificationConfig : SabianCodable {
    
    var title : String!

    var message : String!
    
    var subTitle : String!

    var actions : [String]?

    var showAsProgress : Bool? = false

    var ID : Int!

    var channel : String?

    var hasSound : Bool? = true

    var canVibrate : Bool? = true

    var isBig : Bool? = true

    var progress : Int?
    
    var canProcessPermissions : Bool? = true
    
    init(){
        
    }
    
    init?(fromJson : String) {
        guard let copy : NotificationConfig =  fromJSONOrNull(fromJson) else {
            return nil
        }
        title = copy.title

        message = copy.message
        
        subTitle = copy.subTitle

        actions = copy.actions

        showAsProgress = copy.showAsProgress

        ID = copy.ID

        channel = copy.channel

        hasSound = copy.hasSound

        canVibrate  = copy.canVibrate

        isBig = copy.isBig

        progress = copy.progress
        
        canProcessPermissions = copy.canProcessPermissions
    }
}


extension NotificationConfig {
    
    enum CodingKeys: String, CodingKey {
        
        case title
        
        case subTitle

        case message

        case actions

        case showAsProgress

        case ID

        case channel

        case hasSound

        case canVibrate

        case isBig

        case progress
        
        case canProcessPermissions
    }
}


extension NotificationConfig {
    var toContent : NotificationContent {
        get {
            var content = NotificationContent(title: title)
            if let id = ID {
                content.ID = "PostNotification_\(id)"
            }
            content.body = message
            content.subTitle = subTitle
            content.categoryID = channel
            return content
        }
    }
}
