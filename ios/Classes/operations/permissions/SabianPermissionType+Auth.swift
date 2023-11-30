//
//  SabianPermissionType+Auth.swift
//  Runner
//
//  Created by Sweet Pea on 23/11/2023.
//

import Foundation
import PermissionsKit

extension SabianPermissionsType {
    
    var isGranted : Bool {
        switch self{
        case .camera:
            return Permission.camera.authorized
            
        case .notification:
            return Permission.notification.authorized
            
        case .photoLibrary:
            return Permission.photoLibrary.authorized
            
        case .siri:
            return Permission.siri.authorized
            
        case .unknown:
            return false
        }
    }
}
