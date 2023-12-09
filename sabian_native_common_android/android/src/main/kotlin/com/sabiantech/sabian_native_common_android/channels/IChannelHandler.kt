package com.sabiantech.sabian_native_common_android.channels


import android.util.Log
import androidx.annotation.CallSuper
import com.sabiantech.sabian_native_common_android.channels.utils.ChannelHandlerActivityAwareImpl
import com.sabiantech.sabian_native_common_android.channels.ChannelPayload
import io.flutter.embedding.engine.plugins.activity.ActivityAware

abstract class IChannelHandler<T, A>(protected val channelHandlers: HashMap<String, T> = hashMapOf()) : ActivityAware by ChannelHandlerActivityAwareImpl<T, A>(channelHandlers) {


    protected open fun register(channel: String, action: T) {
        channelHandlers[channel] = action
    }

    abstract fun register()


    @CallSuper
    open fun create(key: String, payload: ChannelPayload) {
        register()
    }

    @CallSuper
    open fun destroy(payload: ChannelPayload) {

    }


    fun execute(channelAction: String, args: A) {
        val action = channelHandlers[channelAction]
        if (action == null) {
            Log.e("sabian_common_native", "No call found for $channelAction")
            return
        }
        execute(action, args)
    }

    protected abstract fun execute(action: T, args: A)

}