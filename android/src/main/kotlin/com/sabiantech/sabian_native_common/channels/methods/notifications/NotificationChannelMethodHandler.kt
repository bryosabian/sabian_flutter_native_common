package com.sabiantech.sabian_native_common.channels.methods.notifications

import android.content.Intent
import com.sabiantech.sabian_native_common.R
import com.sabiantech.sabian_native_common.Config
import com.sabiantech.sabian_native_common.utilities.notifications.NotificationChannel
import com.sabiantech.sabian_native_common.utilities.notifications.Notifier
import com.sabiantech.sabian_native_common.channels.methods.IMethodChannelHandler
import com.sabiantech.sabian_native_common.channels.methods.MethodChannelPayload
import com.sabiantech.sabian_native_common.extensions.fromJSONOrNull
import com.sabiantech.sabian_native_common.utilities.permissions.Permissions
import io.flutter.embedding.android.FlutterActivity

class NotificationChannelMethodHandler : IMethodChannelHandler {

    override fun execute(payload: MethodChannelPayload) {
        val permissions = Permissions(payload.context)
        permissions.proceedIfNotificationPermissionsGranted({
            if (it.isAnyPermissionDenied) {
                payload.result.error("PermissionError", payload.context.getString(R.string.please_accept_all_permissions), null)
                return@proceedIfNotificationPermissionsGranted
            }
            notify(payload)
        }, {
            payload.result.error("PermissionError", it.message, null)
        })
    }

    private fun notify(payload: MethodChannelPayload) {
        val configValue = payload.call.argument<String>("notificationConfig")
        val config = configValue?.fromJSONOrNull<NotificationConfig>()
        if (config == null) {
            payload.result.error(Config.ERROR_CODE, "No notification config passed", null)
            return
        }
        val notifier = Notifier(payload.context, config.ID)
        config.channel?.let {
            notifier.channelID = it
        } ?: run {
            notifier.channelID = NotificationChannel.createImportantChannel(payload.context)
        }
        notifier.title = config.title
        notifier.subTitle = config.message
        notifier.isHasSound = config.hasSound
        notifier.isHasVibrate = config.canVibrate
        notifier.intent = Intent(payload.context, FlutterActivity::class.java)
        if (config.showAsProgress)
            notifier.showProgressNotification(config.progress)
        else
            if (config.isBig)
                notifier.showBigNotification()
            else
                notifier.showNotification()
        payload.result.success(mapOf("status" to "success"))
    }

}