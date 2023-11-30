//
//  NotificationMethodChannelHandler.swift
//  Runner
//
//  Created by Sweet Pea on 23/11/2023.
//

import Foundation

class NotificationMethodChannelHandler : IMethodChannelHandler {
    
    private var lastPayload : MethodChannelPayload? = nil
    
    private var manager : SabianUserNotificationsManager? = nil
    
    private var permissions : SabianPermissions? = nil
    
    func execute(payload: MethodChannelPayload) {
        
        print("sabian_native_common : executing notification")
        
        self.lastPayload = payload
        
        self.permissions = SabianPermissions(context: payload.controller!)
        
        self.permissions?.proceedIfGranted(SabianPermissions.notificationPermissions, { [unowned self] rationale in
            
            if rationale.isAnyPermissionDenied {
                payload.result(SabianException("Please accept all permissions").toFlutterError)
                return
            }
            
            self.manager = SabianUserNotificationsManager(delegate: self)
            
            if let configValue : String = payload.call.argument("notificationConfig"),let notConfig = NotificationConfig(fromJson: configValue) {
                self.manager?.notify(body: notConfig.toContent)
                var map = Dictionary<String,Any>()
                map["status"] = "success"
                payload.result(map)
            }else{
                payload.result(SabianException("No notificaiton passed").toFlutterError)
            }
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
