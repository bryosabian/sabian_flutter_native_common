//
//  PhotoConfig.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation

struct PhotoConfig : SabianCodable {
    
    var galleryMaximumPhotos : Int? = 10
    var galleryShowCamera : Bool? = false
    var galleryAllowMultiple : Bool? = true
    
    
    var galleryAlbumName : String?
    var galleryToolBarTitle : String?
    var galleryLibraryTitle : String?
    var galleryAlbumsTitle : String?
    
    var galleryPrimaryColor : String?
    var galleryPrimaryDarkColor : String?
    
    var allowEditing : Bool? = false
    var cameraTitle : String?
    
    init(){
        
    }
    init?(fromJson : String) {
        guard let copy : PhotoConfig =  fromJSONOrNull(fromJson) else {
            return nil
        }
        
        galleryMaximumPhotos = copy.galleryMaximumPhotos
        galleryShowCamera = copy.galleryShowCamera
        galleryAllowMultiple = copy.galleryAllowMultiple
        
        galleryAlbumName = copy.galleryAlbumName
        galleryToolBarTitle = copy.galleryToolBarTitle
        galleryLibraryTitle = copy.galleryLibraryTitle
        galleryAlbumsTitle = copy.galleryAlbumsTitle
        
        cameraTitle = copy.cameraTitle
        
        galleryPrimaryColor = copy.galleryPrimaryColor
        galleryPrimaryDarkColor = copy.galleryPrimaryDarkColor
        allowEditing = copy.allowEditing
        
    }
    
}

extension PhotoConfig {
    
    enum CodingKeys: String, CodingKey {
        
        case galleryMaximumPhotos
        case galleryShowCamera
        case galleryAllowMultiple
        
        case galleryAlbumName
        case galleryToolBarTitle
        case galleryLibraryTitle
        case galleryAlbumsTitle
        
        case cameraTitle
        
        
        
        case galleryPrimaryColor
        case galleryPrimaryDarkColor
        
        case allowEditing
        
    }
}



extension PhotoConfig {
    var toConfig : SabianPhotoPickerConfig {
        get {
            
            var config = SabianPhotoPickerConfig()
            
            if let galleryToolBarTitle = galleryToolBarTitle {
                config.wordings.libraryTitle = galleryToolBarTitle
            }
            
            if let galleryAlbumName = galleryAlbumName {
                config.wordings.albumName = galleryAlbumName
            }
            
            if let galleryAlbumsTitle = galleryAlbumsTitle {
                config.wordings.albumsTitle = galleryAlbumsTitle
            }
            
            if let galleryLibraryTitle = galleryLibraryTitle {
                config.wordings.libraryTitle = galleryLibraryTitle
            }
            
            if let cameraTitle = cameraTitle {
                config.wordings.cameraTitle = cameraTitle
            }
            
            if let galleryAllowMultiple = galleryAllowMultiple {
                if galleryAllowMultiple != true {
                    config.maximumItems = 1
                }
            }
            
            if let maxPhotos = galleryMaximumPhotos {
                if maxPhotos > 0 {
                    config.maximumItems = maxPhotos
                }
            }
            
            if let allowEditing = allowEditing {
                config.allowEditing = allowEditing
            }
            
           
            
           
            config.theme.primaryColor = galleryPrimaryColor?.toColor
            return config
        }
    }
}
