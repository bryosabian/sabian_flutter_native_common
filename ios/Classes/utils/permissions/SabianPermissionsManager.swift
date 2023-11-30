//
//  SabianPermissionsManager.swift
//  Runner
//
//  Created by Sweet Pea on 19/11/2023.
//

import Foundation
import SPPermissions



class SabianPermissionsManager {
    
    private weak var context : UIViewController?
    
    weak var delegate : SabianPermissionsManagerDelegate?
    
    private var dialog : SPPermissionsDialogController? = nil
    private var list : SPPermissionsListController? = nil
    
    private var needsDialog : Bool {
        get{
            return self.permissions.count <= 3
        }
    }
    
    var title : String? = nil {
        didSet{
            if let title = self.title {
                dialog?.titleText = title
                list?.titleText = title
            }
            
        }
    }
    
    var headerTitle : String? = nil {
        didSet{
            if let title = self.headerTitle {
                dialog?.headerText = title
                list?.headerText = title
            }
            
        }
    }
    
    var footerTitle : String? = nil {
        didSet{
            if let title = self.footerTitle {
                dialog?.footerText = title
                list?.footerText = title
            }
            
        }
    }
    
    var permissions: [SabianPermissionsType] = []
    
    private var _permissions : [SPPermissions.Permission] {
        get{
            return permissions.map { return $0.permission }
        }
    }
    
   
    
    init(context : UIViewController){
        self.context = context
    }
    
    func needsToShow() -> Bool {
        return permissions.contains(where: { p in
            !p.permission.authorized
        })
    }
    
    
    
    func show(){
        if self.needsDialog {
            showDialog()
        }else{
            showList()
        }
    }
    
    private func showDialog(){
        if let dialog = self.dialog {
            if dialog.viewIfLoaded?.window != nil {
                dialog.dismiss(animated: true)
            }
            self.dialog = nil
        }
        
        dialog = SPPermissions.dialog(self._permissions)
        dialog?.delegate = self
        dialog?.dismissCondition = .allPermissionsDeterminated
        dialog?.present(on: self.context!)
    }
    
    private func showList(){
        if let dialog = self.list {
            if dialog.viewIfLoaded?.window != nil {
                dialog.dismiss(animated: true)
            }
            self.list = nil
        }
        list = SPPermissions.list(self._permissions)
        list?.dismissCondition = .allPermissionsDeterminated
        list?.delegate = self
        list?.present(on: self.context!)
    }
    
    
    
}

extension SabianPermissionsManager : SPPermissionsDelegate {
    func didHidePermissions(_ permissions: [SPPermissions.Permission]) {
        delegate?.onFinished(permissions: permissions.map{ return $0.sabianType })
    }
    func didAllowPermission(_ permission: SPPermissions.Permission) {
        delegate?.onAllowed(permission: permission.sabianType)
    }
    func didDeniedPermission(_ permission: SPPermissions.Permission) {
        delegate?.onDenied(permission: permission.sabianType)
    }
}
