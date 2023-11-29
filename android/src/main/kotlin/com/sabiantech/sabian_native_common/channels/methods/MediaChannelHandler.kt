package com.sabiantech.sabian_native_common.channels.methods


import com.sabiantech.sabian_native_common.channels.methods.photo.GalleryMethodChannelHandler
import com.sabiantech.sabian_native_common.channels.methods.photo.PhotoMethodChannelHandler


class MediaChannelHandler : AbstractMethodChannelHandler() {
    override fun register() {
        register("takePicture", PhotoMethodChannelHandler())
        register("choosePicture", GalleryMethodChannelHandler())
    }

}