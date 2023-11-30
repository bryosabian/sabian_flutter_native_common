////  Nygma Period Tracker
//
//  Created by Jared Leto on 26/08/2021.
//  Copyright © 2021 Jared Leto. All rights reserved.

import Foundation
import SPPermissions

class SabianUserNotificationsManager: NSObject {
    
    static let NOTIFICATION_SCHEDULE_LIMIT : Int = 64
    
    
    private var center : UNUserNotificationCenter!
    private var categories : [UNNotificationCategory] = [UNNotificationCategory]()
    
    private var notificationActions : Dictionary<String,()->Void> = Dictionary<String,()->Void>()
    
    weak var delegate : SabianUserNotificationsManagerDelegate? = nil
    
    var settings : UNNotificationSettings? = nil
    var isReady : Bool = false
    var isStarting : Bool = false
    
    var foreGroundOptions : UNNotificationPresentationOptions = [.alert,.sound]
    
    init(delegate : SabianUserNotificationsManagerDelegate? = nil){
        super.init()
        self.delegate = delegate
        center = UNUserNotificationCenter.current()
        center.delegate = self
        if #available(iOS 14.0, *) {
            self.foreGroundOptions.insert(.banner)
        }
    }
    
    func start(delegate : SabianUserNotificationsManagerDelegate? = nil){
        self.fetchNotificationSettings(delegate: delegate)
    }
    
    func requestAuthorization(delegate : SabianUserNotificationsManagerDelegate? = nil) {
        let mDelegate = self.delegate ?? delegate
        center
            .requestAuthorization(options: [.alert, .sound, .badge]) { success, error  in
                if success {
                    self.fetchNotificationSettings(delegate: delegate)
                    mDelegate?.onGranted()
                }else if let error = error {
                    print(error.localizedDescription)
                    mDelegate?.onDenied(error: error)
                }else{
                    mDelegate?.onDenied(error: nil)
                }
            }
    }
    
    func fetchNotificationSettings(delegate : SabianUserNotificationsManagerDelegate? = nil) {
        
        let mDelegate = delegate ?? self.delegate
        
        mDelegate?.onLoadingSettings()
        
        self.isReady = false
        
        self.isStarting = true
        
        center.getNotificationSettings {[weak self] settings in
            
            self?.isStarting = false
            
            self?.isReady = true
            
            self?.settings = settings
            
            if let delegate = mDelegate {
                DispatchQueue.main.async {
                    delegate.onSettingsLoaded(settings: settings,manager: self!)
                }
            }
        }
    }
    
    func canNotify() -> Bool {
        
        let notificationIsEnabledOnLibrary = SPPermissions.Permission.notification.authorized
        
        let notificationIsEnabledOnSettings = settings != nil && settings!.authorizationStatus == .authorized
        
        return notificationIsEnabledOnLibrary || notificationIsEnabledOnSettings
    }
    
    func notify(body : NotificationContent, triggerAfterSeconds : TimeInterval = 1, onError : ((Error) -> Void)? = nil){
        
        if(!self.canNotify()){
            if let onE = onError {
                onE(SabianException("Please approve notification permissions".localize()))
            }
            return
        }
        
        //Content
        let content = body.toContent
        
        //Attach Category ID
        if let catID = body.categoryID {
            content.categoryIdentifier = catID
        }
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: triggerAfterSeconds, repeats: false)
        
        //Get ID
        let mID : String = body.ID ?? UUID().uuidString
        
        // Build request
        let request = UNNotificationRequest(identifier: mID, content: content, trigger: trigger)
        
        // Add notification request
        self.center.add(request) { error in
            if let error = error {
                onError?(error)
            }
        }
        
    }
    
    func scehdule(dateComponents : DateComponents, body : NotificationContent, repeats : Bool = true, onError : ((Error) -> Void)? = nil){
        
        if(!self.canNotify()){
            if let onE = onError {
                onE(SabianException("Please approve notification permissions".localize()))
            }
            return
        }
        
        //Calendar Notification
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
        
        //Content
        let content = body.toContent
        
        //Attach Category ID
        if let catID = body.categoryID {
            content.categoryIdentifier = catID
        }
        
        //ID
        let mID : String = body.ID ?? UUID().uuidString
        
        //Build request
        let request = UNNotificationRequest(identifier: mID, content: content, trigger: trigger)
        
        
        // Add notification request
        self.center.add(request) { error in
            if let error = error {
                onError?(error)
            }
        }
        
    }
    
    
    func cancelNotifications(identifiers : [String]? = nil){
        if let identifiers = identifiers {
            center.removePendingNotificationRequests(withIdentifiers: identifiers)
        }else{
            center.removeAllPendingNotificationRequests()
        }
    }
    
    func addCategory(_ category : UNNotificationCategory){
        self.categories.append(category)
        self.center.setNotificationCategories(Set(categories))
    }
    func addCategory(_ category : [UNNotificationCategory]){
        self.categories.append(contentsOf: category)
        self.center.setNotificationCategories(Set(categories))
    }
    func registerAction(_ key : String, action : @escaping ()->Void){
        self.notificationActions[key] = action
    }
}



extension SabianUserNotificationsManager {
    //MARK: - Singleton
    private static let instance : SabianUserNotificationsManager  = {
        return SabianUserNotificationsManager()
    }()
    
    class func shared() -> SabianUserNotificationsManager {
        return instance
    }
}

//MARK:- Delegate
extension SabianUserNotificationsManager : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(self.foreGroundOptions)
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if let action = self.notificationActions[response.actionIdentifier]{
            action()
        }else{
            print("No action found for \(response.actionIdentifier)")
        }
        completionHandler()
    }
}
