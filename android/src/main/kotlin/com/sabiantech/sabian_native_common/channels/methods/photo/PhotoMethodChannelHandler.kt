package com.sabiantech.sabian_native_common.channels.methods.photo


import android.app.Activity
import android.content.Context
import android.net.Uri
import com.sabiantech.sabian_native_common.R
import com.sabiantech.sabian_native_common.Config
import com.sabiantech.sabian_native_common.channels.methods.IMethodChannelHandler
import com.sabiantech.sabian_native_common.channels.methods.MethodChannelPayload
import com.sabiantech.sabian_native_common.channels.utils.ActivityAwareImpl
import com.sabiantech.sabian_native_common.events.LoaderEvent
import com.sabiantech.sabian_native_common.extensions.toBitmap
import com.sabiantech.sabian_native_common.extensions.toBytes
import com.sabiantech.sabian_native_common.structures.Loader
import com.sabiantech.sabian_native_common.structures.SabianException
import com.sabiantech.sabian_native_common.utilities.media.MediaActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.async
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlin.coroutines.CoroutineContext

class PhotoMethodChannelHandler(private val activityAwareImpl: ActivityAwareImpl = ActivityAwareImpl()) : IMethodChannelHandler, CoroutineScope, ActivityAware by activityAwareImpl {

    private val currentActivity: Activity?
        get() = activityAwareImpl.currentActivity

    override fun execute(payload: MethodChannelPayload) {
        try {
            val activity = currentActivity as? MediaActivity
                    ?: throw SabianException("Activity does not implement MediaActivity")
            activity.takePicture(101, { u, _ ->
                encode(activity, u, payload.result)
            }, {
                payload.result.error("Fuck off", it.message, null)
            })
        } catch (e: Throwable) {
            e.printStackTrace()
            payload.result.error("MediaError", e.message, null)
        }
    }


    private fun encode(context: Context, uri: Uri, result: MethodChannel.Result) {

        val loaderEvent = LoaderEvent

        loaderEvent.raise(Loader(context.getString(R.string.loading), context.getString(R.string.please_wait)))

        var error: Throwable? = null
        val job: Deferred<ByteArray?> = async(Dispatchers.IO) {
            try {
                delay(3000)
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