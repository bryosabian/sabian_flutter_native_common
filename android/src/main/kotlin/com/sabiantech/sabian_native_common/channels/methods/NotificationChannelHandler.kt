package com.sabiantech.sabian_native_common.channels.methods


import com.sabiantech.sabian_native_common.channels.methods.notifications.NotificationChannelMethodHandler


class NotificationChannelHandler : AbstractMethodChannelHandler() {
    override fun register() {
        register("postNotification", NotificationChannelMethodHandler())
    }

}