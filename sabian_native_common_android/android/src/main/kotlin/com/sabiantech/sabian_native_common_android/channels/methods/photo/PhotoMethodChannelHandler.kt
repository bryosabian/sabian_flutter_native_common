package com.sabiantech.sabian_native_common_android.channels.methods.photo


import android.app.Activity
import android.content.Context
import android.net.Uri
import com.sabiantech.sabian_native_common_android.R
import com.sabiantech.sabian_native_common_android.channels.methods.IMethodChannelHandler
import com.sabiantech.sabian_native_common_android.channels.methods.MediaChannelHandler.Companion.MEDIA_ERROR_CODE
import com.sabiantech.sabian_native_common_android.channels.methods.MethodChannelPayload
import com.sabiantech.sabian_native_common_android.channels.utils.ActivityAwareImpl
import com.sabiantech.sabian_native_common_android.events.LoaderEvent
import com.sabiantech.sabian_native_common_android.extensions.fromJSONOrNull
import com.sabiantech.sabian_native_common_android.extensions.toBitmap
import com.sabiantech.sabian_native_common_android.extensions.toBytes
import com.sabiantech.sabian_native_common_android.structures.Loader
import com.sabiantech.sabian_native_common_android.structures.SabianException
import com.sabiantech.sabian_native_common_android.utilities.media.MediaActivity
import com.sabiantech.sabian_native_common_android.utilities.permissions.Permissions
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import kotlin.coroutines.CoroutineContext

class PhotoMethodChannelHandler(private val activityAwareImpl: ActivityAwareImpl = ActivityAwareImpl()) : IMethodChannelHandler, CoroutineScope, ActivityAware by activityAwareImpl {

    private val currentActivity: Activity?
        get() = activityAwareImpl.currentActivity

    override fun execute(payload: MethodChannelPayload) {
        try {

            val activity = currentActivity as? MediaActivity
                    ?: throw SabianException("Activity does not implement MediaActivity")

            val configValue = payload.call.argument<String>("photoConfig")

            val photoConfig = configValue?.fromJSONOrNull<PhotoConfig>()

            val canProcessPermissions = photoConfig?.canProcessPermissions ?: true

            val proceed = {
                activity.takePicture(101, { u, _ ->
                    encode(activity, u, payload.result)
                }, {
                    payload.result.error(MEDIA_ERROR_CODE, it.message, null)
                })
            }

            if (!canProcessPermissions) {
                proceed.invoke()
                return
            }

            val permissions = Permissions(activity)

            permissions.proceedIfPhotoPermissionsGranted({
                if (it.isAnyPermissionDenied) {
                    payload.result.error(Permissions.PERMISSIONS_ERROR_CODE, activity.getString(R.string.please_accept_all_permissions), null)
                    return@proceedIfPhotoPermissionsGranted
                }
                proceed.invoke()
            })

        } catch (e: Throwable) {
            e.printStackTrace()
            payload.result.error(MEDIA_ERROR_CODE, e.message, null)
        }
    }


    private fun encode(context: Context, uri: Uri, result: MethodChannel.Result) {

        val loaderEvent = LoaderEvent

        loaderEvent.raise(Loader(context.getString(R.string.loading), context.getString(R.string.please_wait)))

        var error: Throwable? = null
        val job: Deferred<ByteArray?> = async(Dispatchers.IO) {
            try {
                val bmp = uri.toBitmap(context)
                val bytes = bmp.toBytes()
                bytes
            } catch (e: Throwable) {
                e.printStackTrace()
                error = e
                null
            }
        }
        launch {
            val arr = job.await()
            loaderEvent.raise(Loader(isHidden = true))
            error?.let {
                result.error("MediaError", it.message, "")
            } ?: kotlin.run {
                result.success(mapOf("status" to "success", "data" to arr))
            }
        }
    }

    override val coroutineContext: CoroutineContext
        get() = SupervisorJob() + Dispatchers.Main
}