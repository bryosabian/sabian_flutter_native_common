//
//  SabianPhotoPickerConfig.swift
//  Runner
//
//  Created by bryosabian on 21/11/2023.
//

import Foundation


struct SabianPhotoPickerConfig {
    static var `default` : SabianPhotoPickerConfig {
        get {
            return SabianPhotoPickerConfig()
        }
    }
    var allowEditing : Bool = false
    var maximumItems : Int = 1
    var wordings = PhotoPickerWordings()
    var theme = PhotoPickerTheme()
    
    struct PhotoPickerWordings {
        var warningMaxItemsLimit : String! = "You are only allowed up to %d photos".localize()
        var libraryTitle = "Gallery".localize()
        var cameraTitle = "Camera".localize()
        var albumsTitle = "Albums".localize()
        var albumName : String = "Gallery".localize()
    }
    
    struct PhotoPickerTheme {
        var primaryColor : UIColor?
    }
}
