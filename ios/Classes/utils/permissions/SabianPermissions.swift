//
//  SabianPermissions.swift
//  Runner
//
//  Created by Sweet Pea on 20/11/2023.
//

import Foundation

class SabianPermissions {
    
    private var accepted : Set<SabianPermissionsType> = []
    
    private var denied : Set<SabianPermissionsType> = []
    
    private var onProceed : ((PermissionRationale) -> Void)? = nil
    
    private var onError : ((Error) -> Void)? = nil
    
    private var manager : SabianPermissionsManager?
    
    private var rationale : PermissionRationale? = nil
    
    
    static var neededPermissions : [SabianPermissionsType] {
        get{
            return [.camera, .notification,.photoLibrary]
        }
    }
    
    static var photoPermissions : [SabianPermissionsType] {
        get{
            return [.camera,.photoLibrary]
        }
    }
    
    static var notificationPermissions : [SabianPermissionsType]{
        get{
            return [.notification]
        }
    }
    
    init(context : UIViewController){
        self.manager = SabianPermissionsManager(context: context)
        self.manager?.delegate = self
    }
    
    deinit {
        print("Sabian Permissions deinited")
        self.manager = nil
        self.reset()
    }
    
}


extension SabianPermissions {
    func isPermissionAuthorized(_ permission : SabianPermissionsType) -> Bool{
        return permission.isGranted
    }
}

extension SabianPermissions {
    
    private func run(_ rationale: PermissionRationale, onProceed: @escaping (PermissionRationale) -> Void, onError: ((Error) -> Void)? = nil) {
        do {
            self.reset()
            self.rationale = rationale
            self.onProceed = onProceed
            self.onError = onError
            let valid = rationale.validPermissions
            if valid.isEmpty {
                self.finish(permissions: rationale.permissions)
                return
            }
            self.processAlreadyAcceptedPermissions()
            if(self.accepted.count == rationale.permissions.count){
                self.finish(permissions: rationale.permissions)
                print("All permissions already accepted")
                return
            }
            self.manager?.permissions = valid
            self.manager?.show()
        }catch{
            self.onError(error: error)
        }
    }
    
    private func processAlreadyAcceptedPermissions(){
        self.rationale!.permissions.forEach( { [unowned self] permission in
            if permission.isGranted{
                print("Permissions \(permission) already accepted")
                self.accepted.insert(permission)
            }
        })
    }
    
    
    private func finish(permissions : [SabianPermissionsType]){
        guard let rationale = self.rationale else {
            onError(error: SabianException("No rationale found"))
            return
        }
        self.rationale?.accepted = self.accepted.toArray
        self.rationale?.denied = self.denied.toArray
        if let proceed = onProceed {
            proceed(self.rationale!)
        }
    }
    
    
    private func onError(error : Error){
        if let eHandler = self.onError {
            eHandler(error)
        }
    }
}


extension SabianPermissions {
    
    func proceedIfGranted(_ permissions :  Array<SabianPermissionsType>,
                          _ onProceed: @escaping (PermissionRationale) -> Void,
                          onError: ((Error) -> Void)? = nil,  allMandatory: Bool = true){
        request(permissions, onProceed: onProceed, allMandatory: allMandatory, onError: onError)
    }
    
    func request(
               _ permissions: Array<SabianPermissionsType>,
               onProceed: @escaping (PermissionRationale) -> Void,
               allMandatory: Bool = true,
               onError: ((Error) -> Void)? = nil
       ) {
           let rationale = PermissionRationale(permissions)
           rationale.allMandatory = allMandatory
           request(rationale, onProceed : onProceed, onError : onError)
       }

       func request(
               _ rationale: PermissionRationale,
               onProceed: @escaping (PermissionRationale) -> Void,
               onError: ((Error) -> Void)? = nil
       ) {
           rationale.onRequested = onProceed
           rationale.onError = onError
           self.run(rationale, onProceed : onProceed, onError : onError)

       }
    
    
    func reset(){
        self.rationale = nil
        self.denied.removeAll()
        self.accepted.removeAll()
    }
}


extension SabianPermissions {
    
    func proceedIfPhotoPermissionsGranted(
                          _ onProceed: @escaping (PermissionRationale) -> Void,
                          onError: ((Error) -> Void)? = nil,  allMandatory: Bool = true){
                              self.proceedIfGranted(SabianPermissions.photoPermissions, onProceed, onError: onError, allMandatory: allMandatory)
    }
    
    
    func proceedIfNeededPermissionsGranted(
                          _ onProceed: @escaping (PermissionRationale) -> Void,
                          onError: ((Error) -> Void)? = nil,  allMandatory: Bool = true){
                              self.proceedIfGranted(SabianPermissions.neededPermissions, onProceed, onError: onError, allMandatory: allMandatory)
    }
    
    func proceedIfNotificationPermissionsGranted(
                          _ onProceed: @escaping (PermissionRationale) -> Void,
                          onError: ((Error) -> Void)? = nil,  allMandatory: Bool = true){
                              self.proceedIfGranted(SabianPermissions.notificationPermissions, onProceed, onError: onError, allMandatory: allMandatory)
    }
}

extension SabianPermissions : SabianPermissionsManagerDelegate {
    func onFinished(permissions : [SabianPermissionsType]){
        print("Permissions have been dismissed")
        self.finish(permissions: permissions)
    }
    func onAllowed(permission : SabianPermissionsType){
        self.accepted.insert(permission)
        print("Permissions has been allowed")
    }
    func onDenied(permission : SabianPermissionsType){
        self.denied.insert(permission)
        print("Permission has been denied")
    }
}


