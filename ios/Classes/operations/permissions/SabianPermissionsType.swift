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
    case siri
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
        case .siri:
            return .siri
        case .unknown:
            return .init()
        }
    }
    
    
}
