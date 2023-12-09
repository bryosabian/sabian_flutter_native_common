//
//  SabianUserNotificationsManagerDelegate.swift
//  sabian_native_common
//
//  Created by bryosabian on 01/12/2023.
//

import Foundation

protocol SabianUserNotificationsManagerDelegate : AnyObject {
    func onGranted()
    func onDenied(error : Error?)
    func onSettingsLoaded(settings : UNNotificationSettings, manager : SabianUserNotificationsManager)
    func onLoadingSettings()
}

extension SabianUserNotificationsManagerDelegate {
    func onGranted(){
        
    }
    func onDenied(error : Error?){
        
    }
    func onSettingsLoaded(settings : UNNotificationSettings, manager : SabianUserNotificationsManager){
        
    }
    func onLoadingSettings(){
        
    }
}
