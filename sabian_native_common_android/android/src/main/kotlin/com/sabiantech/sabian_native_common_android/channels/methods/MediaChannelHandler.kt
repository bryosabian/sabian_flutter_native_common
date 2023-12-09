package com.sabiantech.sabian_native_common_android.channels.methods


import com.sabiantech.sabian_native_common_android.Config
import com.sabiantech.sabian_native_common_android.channels.methods.photo.GalleryMethodChannelHandler
import com.sabiantech.sabian_native_common_android.channels.methods.photo.PhotoMethodChannelHandler


class MediaChannelHandler : AbstractMethodChannelHandler() {
    companion object {
        const val MEDIA_ERROR_CODE = Config.MEDIA_ERROR_CODE
    }

    override fun register() {
        register("takePicture", PhotoMethodChannelHandler())
        register("choosePicture", GalleryMethodChannelHandler())
    }

}