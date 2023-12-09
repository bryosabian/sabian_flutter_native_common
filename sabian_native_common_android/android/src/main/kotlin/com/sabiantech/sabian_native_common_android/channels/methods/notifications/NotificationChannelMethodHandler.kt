package com.sabiantech.sabian_native_common_android.channels.methods.notifications

import android.content.Intent
import com.sabiantech.sabian_native_common_android.R
import com.sabiantech.sabian_native_common_android.Config
import com.sabiantech.sabian_native_common_android.utilities.notifications.NotificationChannel
import com.sabiantech.sabian_native_common_android.utilities.notifications.Notifier
import com.sabiantech.sabian_native_common_android.channels.methods.IMethodChannelHandler
import com.sabiantech.sabian_native_common_android.channels.methods.MediaChannelHandler
import com.sabiantech.sabian_native_common_android.channels.methods.MethodChannelPayload
import com.sabiantech.sabian_native_common_android.extensions.fromJSONOrNull
import com.sabiantech.sabian_native_common_android.structures.SabianException
import com.sabiantech.sabian_native_common_android.utilities.permissions.Permissions
import io.flutter.embedding.android.FlutterActivity

class NotificationChannelMethodHandler : IMethodChannelHandler {

    override fun execute(payload: MethodChannelPayload) {
        try {

            val configValue = payload.call.argument<String>("notificationConfig")

            val config = configValue?.fromJSONOrNull<NotificationConfig>()
                    ?: throw SabianException("No notification config passed")

            val proceed = {
                notify(config, payload)
            }
            if (!config.canProcessPermissions) {
                proceed.invoke()
                return
            }
            val permissions = Permissions(payload.context)
            permissions.proceedIfNotificationPermissionsGranted({
                if (it.isAnyPermissionDenied) {
                    payload.result.error(Config.PERMISSIONS_ERROR_CODE, payload.context.getString(R.string.please_accept_all_permissions), null)
                    return@proceedIfNotificationPermissionsGranted
                }
                proceed.invoke()
            }, {
                payload.result.error(Config.PERMISSIONS_ERROR_CODE, it.message, null)
            })
        } catch (e: Throwable) {
            e.printStackTrace()
            payload.result.error(Config.NOTIFICATION_ERROR_CODE, e.message, null)
        }
    }

    private fun notify(config: NotificationConfig, payload: MethodChannelPayload) {
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