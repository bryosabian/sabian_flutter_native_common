//
//  SabianPermissionsManagerDelegate.swift
//  Runner
//
//  Created by Sweet Pea on 20/11/2023.
//

import Foundation



protocol SabianPermissionsManagerDelegate : AnyObject {
    func onFinished(permissions : [SabianPermissionsType])
    func onAllowed(permission : SabianPermissionsType)
    func onDenied(permission : SabianPermissionsType)
}


extension SabianPermissionsManagerDelegate {
    func onFinished(permissions : [SabianPermissionsType]){
        //Do nothing
    }
    func onAllowed(permission : SabianPermissionsType){
        
    }
    func onDenied(permission : SabianPermissionsType){
        
    }
}
