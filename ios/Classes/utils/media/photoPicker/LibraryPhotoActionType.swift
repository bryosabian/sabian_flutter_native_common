//
//  LibraryPhotoActionType.swift
//  Runner
//
//  Created by Sweet Pea on 21/11/2023.
//

import Foundation
import YPImagePicker

class LibraryPhotoActionType : IPhotoActionType {
    
    private var picker : YPImagePicker? = nil
    private weak var delegate : SabianPhotoPickerDelegate? = nil
    private var config : SabianPhotoPickerConfig!
    
    
    func takePicture(context : UIViewController,delegate : SabianPhotoPickerDelegate?,config : SabianPhotoPickerConfig){
        self.delegate = delegate
        self.config = config
        initLibrary(.Photo)
        context.present(picker!, animated: true, completion: nil)
    }
    func choosePicture(context : UIViewController, delegate : SabianPhotoPickerDelegate?,config : SabianPhotoPickerConfig){
        self.delegate = delegate
        self.config = config
        initLibrary(.Library)
        context.present(picker!, animated: true, completion: nil)
    }
    private func initLibrary(_ screenType : SabianPhotoPickerScreenType = .Photo){
        if(picker != nil){
            picker = nil
        }
        let config = screenType.toYPConfig(pickerConfig: self.config)
        picker = YPImagePicker(configuration: config)
        picker?.didFinishPicking { [unowned picker] items, _ in
            var photos = [UIImage]()
            items.forEach { item in
                switch item {
                
                case .photo(let photo):
                    photos.append(photo.image)
                    
                default:
                    print("Fuck you apple")
                //Do nothing. Fuck you Apple!!
                }
                
                
            }
            if photos.count > 0 {
                self.delegate?.onPhotoSuccess(photos)
            }else{
                self.delegate?.onPhotoError(SabianException("Could not pick or take photo".localize()))
            }
            picker?.dismiss(animated: true, completion: nil)
        }
    }
}


extension SabianPhotoPickerScreenType {
    
    func toYPConfig(pickerConfig : SabianPhotoPickerConfig) -> YPImagePickerConfiguration {
        
        var ypScreenTypes : [YPPickerScreen] = [.photo]
        if(self == .Library){
            ypScreenTypes.append(.library)
        }
        
        var config = YPImagePickerConfiguration.shared
        config.library.mediaType = .photo
        config.library.options = nil
        
        config.library.maxNumberOfItems = pickerConfig.maximumItems
        
        
        config.screens = ypScreenTypes
        config.showsPhotoFilters = pickerConfig.allowEditing
        config.showsVideoTrimmer = pickerConfig.allowEditing
        config.shouldSaveNewPicturesToAlbum = true
        
        config.wordings.warningMaxItemsLimit = pickerConfig.wordings.warningMaxItemsLimit.format(args: pickerConfig.maximumItems)
        
        config.wordings.libraryTitle = pickerConfig.wordings.libraryTitle
        config.wordings.cameraTitle = pickerConfig.wordings.cameraTitle
        config.wordings.next = "OK".localize()
        config.wordings.permissionPopup.grantPermission = "Please grant permission".localize()
        config.wordings.permissionPopup.title = "Permission Required".localize()
        config.wordings.permissionPopup.message = "Permission is required before accessing the photo library".localize()
        config.wordings.albumsTitle = pickerConfig.wordings.albumsTitle
        
        config.albumName = pickerConfig.wordings.albumName
        
        
        if let color = pickerConfig.theme.primaryColor {
            config.colors.tintColor = color
            config.colors.positionLineColor = color
            config.colors.albumTitleColor = color
            config.colors.albumTintColor = color
            config.colors.navigationBarActivityIndicatorColor = color
        }
        
        return config
        
        
    }
  
}
