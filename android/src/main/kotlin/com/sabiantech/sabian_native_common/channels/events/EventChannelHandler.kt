package com.sabiantech.sabian_native_common.channels.events

import android.util.Log
import com.sabiantech.sabian_native_common.channels.ChannelPayload
import com.sabiantech.sabian_native_common.channels.IChannelHandler
import com.sabiantech.sabian_native_common.events.ErrorEvent
import com.sabiantech.sabian_native_common.events.LoaderEvent
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler

class EventChannelHandler : IChannelHandler<StreamHandler, EventChannelPayload>() {
    override fun register() {
        register("com.sabian_common_native.events.loader", LoaderEvent)
        register("com.sabian_common_native.events.error", ErrorEvent)
    }

    override fun create(key: String, payload: ChannelPayload) {
        super.create(key, payload)
        channelHandlers.forEach { (t, u) ->
            execute(u, EventChannelPayload(t, payload.messenger))
        }
    }

    override fun execute(action: StreamHandler, args: EventChannelPayload) {
        Log.e("sabian_common_native", "Executing event for ${args.channelName}")
        EventChannel(args.messenger, args.channelName).setStreamHandler(
                action
        )
    }
}