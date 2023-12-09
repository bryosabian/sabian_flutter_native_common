//
//  SabianNativePermissionsList.swift
//  sabian_native_common
//
//  Created by bryosabian on 03/12/2023.
//

import Foundation
import SPPermissions

class SabianNativePermissionsList {
    
    static var permissions : Dictionary<String,SPPermissions.Permission> {
        var permissions = Dictionary<String,SPPermissions.Permission>()
        permissions["Camera"] = SPPermissions.Permission.camera
        permissions["Notification"] = SPPermissions.Permission.notification
        permissions["Photo Library"] = SPPermissions.Permission.photoLibrary
        return permissions
    }
    
    static func getPermission(_ key : String) -> SPPermissions.Permission? {
        guard let current = permissions[key]  else {
            return nil
        }
        return current
    }
}
