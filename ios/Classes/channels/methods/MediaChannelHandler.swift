//
//  MediaChannelHandler.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation


class MediaChannelHandler : AbstractMethodChannelHandler {

    override func register() {
        register("takePicture", PhotoMethodChannelHandler())
        register("choosePicture", GalleryMethodChannelHandler())
    }
}
