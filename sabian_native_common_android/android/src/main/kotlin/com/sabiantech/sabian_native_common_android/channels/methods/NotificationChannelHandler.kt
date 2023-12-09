package com.sabiantech.sabian_native_common_android.channels.methods


import com.sabiantech.sabian_native_common_android.channels.methods.notifications.NotificationChannelMethodHandler


class NotificationChannelHandler : AbstractMethodChannelHandler() {
    override fun register() {
        register("postNotification", NotificationChannelMethodHandler())
    }

}