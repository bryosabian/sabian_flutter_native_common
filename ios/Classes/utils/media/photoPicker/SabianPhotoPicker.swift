//
//  SabianPhotoPage.swift
//  Nygma Period Tracker
//
//  Created by Jared Leto on 20/07/2021.
//  Copyright © 2021 Jared Leto. All rights reserved.
//

import Foundation
import UIKit
import YPImagePicker

class SabianPhotoPicker {
    
    private weak var context : UIViewController?
    private weak var delegate : SabianPhotoPickerDelegate? = nil
    
    private var actionTypes : Dictionary<String,IPhotoActionType>!
    private var actionType : String = "library"
    
    var config : SabianPhotoPickerConfig!
    
    var permissions : SabianPermissions!
    
    init(_ context : UIViewController, delegate : SabianPhotoPickerDelegate,config : SabianPhotoPickerConfig = .default){
        self.context = context
        self.delegate = delegate
        self.config = config
        self.permissions = SabianPermissions(context: context)
        actionTypes = Dictionary<String,IPhotoActionType>()
        actionTypes["library"] = LibraryPhotoActionType()
    }
    
    func takePhoto(onError : ((Error) -> Void)? = nil){
        guard let at = actionTypes[self.actionType] else {
            return
        }
        self.proceedIfPermissionsGranted({ [unowned self] in
            at.takePicture(context: self.context!, delegate: self.delegate,config: self.config)
        },onError: onError)
    }
    
    func choosePhoto(onError : ((Error) -> Void)? = nil){
        guard let at = actionTypes[self.actionType] else {
            return
        }
        self.proceedIfPermissionsGranted({ [unowned self] in
            at.choosePicture(context: self.context!, delegate: self.delegate,config: self.config)
        },onError:  onError)
        
    }
    
    private func proceedIfPermissionsGranted(_ onProceed : @escaping () -> Void, onError : ((Error) -> Void)? = nil){
        permissions.proceedIfGranted(SabianPermissions.photoPermissions, { rationale in
            
            if rationale.isAnyPermissionDenied {
                if let onE = onError {
                    onE(SabianException("Please accept all permissions".localize()))
                }
                return
            }
            
            onProceed()
            
        },onError: onError)
    }
}
