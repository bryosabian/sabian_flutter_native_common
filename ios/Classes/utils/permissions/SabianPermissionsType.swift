//
//  SabianPermissionsType.swift
//  Runner
//
//  Created by bryosabian on 20/11/2023.
//

import Foundation
import SPPermissions


enum SabianPermissionsType : String,CaseIterable {
    case notification = "Notification"
    case photoLibrary = "Photo Library"
    case camera = "Camera"
    case unknown = "Unknown"
    
    var name : String{
        return self.rawValue
    }
    
    var permission : SPPermissions.Permission? {
        return SabianNativePermissionsList.getPermission(self.name)
    }
    
    var isGranted : Bool {
        if let permission = self.permission {
            return permission.authorized
        }else{
            return true
        }
    }
}

extension SPPermissions.Permission {
    var sabianType : SabianPermissionsType? {
        let key = self.type.name
        for per in SabianPermissionsType.allCases {
            if per.name == key {
                return per
            }
        }
        return nil
    }
}

