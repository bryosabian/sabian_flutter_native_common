//
//  PermissionRationale.swift
//  Runner
//
//  Created by Sweet Pea on 20/11/2023.
//

import Foundation
class PermissionRationale {
       var permissions: [SabianPermissionsType] = []
       var allMandatory: Bool = true
       var description: String? = nil
       var onRequested: ((PermissionRationale) -> Void)? = nil
       var accepted: [SabianPermissionsType]? = nil
       var denied: [SabianPermissionsType]? = nil
       var onError: ((Error) -> Void)? = nil
       var areAllDenied: Bool? = nil
       var isAnyDenied: Bool? = nil
       var isAnyDeniedPermanently: Bool? = nil
    
    init(_ permissions : [SabianPermissionsType]){
        self.permissions = permissions
    }
    
    var areAllPermissionsDenied : Bool{
        get {
            if(areAllDenied != nil){
                return areAllDenied!
            }
            let denied = self.denied ?? []
            return permissions.count == denied.count
        }
    }
    
    var isAnyPermissionDenied : Bool {
        get {
            if(isAnyDenied != nil){
                return isAnyDenied!
            }
            let denied = denied ?? []
            return permissions.contains(where: { per in
                    denied.contains(per)
                })
        }
    }
    
    var isAnyPermissionAccepted : Bool {
        get {
            if(areAllPermissionsDenied){
                return false
            }
            let accepted = accepted ?? []
            return permissions.contains(where: { per in
                    accepted.contains(per)
                })
        }
    }

    var areAllPermissionsAccepted : Bool {
        get {
            if(isAnyPermissionDenied){
                return false
            }
            return accepted?.count == permissions.count
        }
    }


      func isPermissionDenied(permission: SabianPermissionsType) -> Bool {
          return denied?.contains(permission) ?? false
      }

      func isPermissionAccepted(permission: SabianPermissionsType) -> Bool {
          return accepted?.contains(permission) ?? false
      }
}
