//
//  SabianPermissionsType.swift
//  Runner
//
//  Created by Sweet Pea on 20/11/2023.
//

import Foundation
import SPPermissions


enum SabianPermissionsType {
    case notification
    case photoLibrary
    case camera
    case unknown
    
    var permission : SPPermissions.Permission {
        switch self {
        case .camera:
            return .camera
        case .notification:
            return .notification
        case .photoLibrary:
            return .photoLibrary
        case .unknown:
            return .init()
        }
    }
    
    var isGranted : Bool {
        return self.permission.authorized
    }
}

extension SPPermissions.Permission {
    var sabianType : SabianPermissionsType {
        get{
            switch self {
            case .camera:
                return .camera
            case .notification:
                return .notification
            case .photoLibrary:
                return .photoLibrary
            default:
                return .unknown
            }
        }
    }
}

