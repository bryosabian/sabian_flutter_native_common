//
//  GalleryMethodChannelHandler.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation
import Flutter

class GalleryMethodChannelHandler : IMethodChannelHandler,SabianPhotoPickerDelegate{
    
    private var lastPayload : MethodChannelPayload? = nil
    
    private var picker : SabianPhotoPicker? = nil
    
    private var task : SabianAsyncTask<[Data]?>? = nil
    
    func execute(payload: MethodChannelPayload) {
        
        print("sabian_native_common : executing choosing photo")
        
        self.lastPayload = payload
        
        self.picker = SabianPhotoPicker(payload.controller!,delegate: self)
        
        var canProceddPermissions = true
        
        if let configValue : String = payload.call.argument("photoConfig"),let photoConfig = PhotoConfig(fromJson: configValue) {
            canProceddPermissions = photoConfig.canProcessPermissions ?? true
            picker!.config = photoConfig.toConfig
            print("Picker config has been set")
        }else{
            print("No picker config has been set")
        }
        
        picker!.choosePhoto(onError: { error  in
            print("Gallery Error \(error)")
            payload.result(error.toFlutterError)
        },processPermissions: canProceddPermissions)
    }


    private func encode(_ images : [UIImage], result: @escaping FlutterResult) {
        
        LoaderEvent.shared.raise(Loader(title: "Loading gallery photo",message: "Please wait"))
        
        task = SabianAsyncTask<[Data]?>()
        
        task!.execute({
            var all : [Data] = []
            images.forEach({ elem in
                let data = elem.pngData()!
                all.append(data)
            })
            print("GMCH Found \(all.count) passed")
            return all
        },onComplete : { data in
            LoaderEvent.shared.raise(Loader(isHidden: true))
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
        print("Gallery method handler deinited")
    }
}


extension GalleryMethodChannelHandler {
    func onPhotoSuccess(_ images : [UIImage]){
        self.encode(images, result: self.lastPayload!.result)
    }
    func onPhotoError(_ error : Error){
        self.lastPayload!.result(error.toFlutterError)
    }
}
