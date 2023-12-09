package com.sabiantech.sabian_native_common_android.channels.methods

import android.util.Log
import com.sabiantech.sabian_native_common_android.channels.ChannelPayload
import com.sabiantech.sabian_native_common_android.channels.IChannelHandler
import io.flutter.plugin.common.MethodChannel

abstract class AbstractMethodChannelHandler : IChannelHandler<IMethodChannelHandler, MethodChannelPayload>() {

    override fun create(key: String, payload: ChannelPayload) {
        super.create(key, payload)
        Log.e("sabian_common_native", "Created method channels for $key")
        val channel = MethodChannel(payload.messenger, key)
        channel.setMethodCallHandler { call, result ->
            execute(call.method, MethodChannelPayload(payload.context, result, call))
        }
    }

    override fun execute(action: IMethodChannelHandler, args: MethodChannelPayload) {
        action.execute(args)
    }
}