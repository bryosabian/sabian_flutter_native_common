//
//  PhotoMethodChannelHandler.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation
import Flutter

class PhotoMethodChannelHandler : IMethodChannelHandler,SabianPhotoPickerDelegate{
    
    private var lastPayload : MethodChannelPayload? = nil
    
    private var picker : SabianPhotoPicker? = nil
    
    private var task : SabianAsyncTask<Data?>? = nil
    
    func execute(payload: MethodChannelPayload) {
        
        print("sabian_native_common : executing taking photo")
        
        self.lastPayload = payload
        
        self.picker = SabianPhotoPicker(payload.controller!,delegate: self)
        
        var canProceddPermissions = true
        
        if let configValue : String = payload.call.argument("photoConfig"),let photoConfig = PhotoConfig(fromJson: configValue) {
            canProceddPermissions = photoConfig.canProcessPermissions ?? true
            picker!.config = photoConfig.toConfig
        }
        
        picker!.takePhoto(onError: { error in
            print("Photo Error \(error)")
            payload.result(error.toFlutterError)
        },processPermissions: canProceddPermissions)
    }


    private func encode(_ image : UIImage, result: @escaping FlutterResult) {
        
        LoaderEvent.shared.raise(Loader(title: "Loading photo",message: "Please wait"))
        
        task = SabianAsyncTask<Data?>()
        task!.execute({
            return image.pngData()
        },onComplete : { data in
            LoaderEvent.shared.raise(Loader(isHidden : true))
            var map = Dictionary<String,Any>()
            map["status"] = "success"
            map["data"] = data!
            result(map)
        }, onError: { error in
            LoaderEvent.shared.raise(Loader(isHidden: true))
            result(error.toFlutterError)
        })
    }
    
    deinit{
        picker = nil
        lastPayload = nil
        task = nil
        print("Photo method handler deinited")
    }
}


extension PhotoMethodChannelHandler {
    func onPhotoSuccess(_ images : [UIImage]){
        let image = images.first!
        self.encode(image, result: self.lastPayload!.result)
    }
    func onPhotoError(_ error : Error){
        self.lastPayload!.result(error.toFlutterError)
    }
}
