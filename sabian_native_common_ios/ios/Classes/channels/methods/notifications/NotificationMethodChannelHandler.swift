//
//  NotificationMethodChannelHandler.swift
//  Runner
//
//  Created by bryosabian on 23/11/2023.
//

import Foundation

class NotificationMethodChannelHandler : IMethodChannelHandler {
    
    private var lastPayload : MethodChannelPayload? = nil
    
    private var manager : SabianUserNotificationsManager? = nil
    
    private var permissions : SabianPermissions? = nil
    
    func execute(payload: MethodChannelPayload) {
        
        print("sabian_native_common : executing notification")
        
        self.lastPayload = payload
        
        var notificationConfig : NotificationConfig
        
        if let configValue : String = payload.call.argument("notificationConfig"),let notConfig = NotificationConfig(fromJson: configValue) {
            notificationConfig = notConfig
        }else{
            payload.result(SabianException("No notificaiton passed").toFlutterError)
            return
        }
        
        let proceed = { [unowned self] in
            self.manager = SabianUserNotificationsManager(delegate: self)
            self.manager?.notify(body: notificationConfig.toContent)
            var map = Dictionary<String,Any>()
            map["status"] = "success"
            payload.result(map)
        }
        
        let canProcesPermissions = notificationConfig.canProcessPermissions ?? true
        
        if(!canProcesPermissions){
            proceed()
            return
        }
        
        self.permissions = SabianPermissions(context: payload.controller!)
        
        self.permissions?.proceedIfGranted(SabianPermissions.notificationPermissions, { rationale in
            if rationale.isAnyPermissionDenied {
                payload.result(SabianException("Please accept all permissions").toFlutterError)
                return
            }
            proceed()
        })
        
    }
    
    
    deinit {
        self.lastPayload = nil
        self.manager = nil
    }
    
}

extension NotificationMethodChannelHandler : SabianUserNotificationsManagerDelegate {
    
    func onDenied(error : Error?){
        if let res = self.lastPayload?.result {
            res(error?.toFlutterError ?? SabianException("Please accept all permissions").toFlutterError)
        }
    }
}
