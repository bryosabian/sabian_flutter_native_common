package com.sabiantech.sabian_native_common_android.channels


import com.sabiantech.sabian_native_common_android.channels.events.EventChannelHandler
import com.sabiantech.sabian_native_common_android.channels.methods.DeviceChannelHandler
import com.sabiantech.sabian_native_common_android.channels.methods.MediaChannelHandler
import com.sabiantech.sabian_native_common_android.channels.methods.NotificationChannelHandler
import com.sabiantech.sabian_native_common_android.channels.ChannelPayload
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class ChannelsManager : ActivityAware {

    private val methodChannelHandlers: Map<String, IChannelHandler<*, *>> by lazy {
        mapOf("com.sabian_common_native.methods.media" to MediaChannelHandler(),
                "com.sabian_common_native.methods.notifications" to NotificationChannelHandler(),
                "com.sabian_common_native.methods.device" to DeviceChannelHandler()
        )
    }

    private val eventChannelHandlers: Map<String, IChannelHandler<*, *>> by lazy {
        mapOf("com.sabian_common_native.events" to EventChannelHandler())
    }


    fun setUp(payload: ChannelPayload) {
        setUpEventChannels(payload)
        setUpMethodChannels(payload)
    }

    fun destroy(payload: ChannelPayload) {
        destroyMethodChannels(payload)
        destroyEventChannels(payload)
    }

    private fun setUpEventChannels(payload: ChannelPayload) {
        eventChannelHandlers.forEach { (t, u) ->
            u.create(t, payload)
        }
    }

    private fun setUpMethodChannels(payload: ChannelPayload) {
        methodChannelHandlers.forEach { (t, u) ->
            u.create(t, payload)
        }
    }

    private fun destroyEventChannels(payload: ChannelPayload) {
        eventChannelHandlers.forEach { (t, u) ->
            u.destroy(payload)
        }
    }

    private fun destroyMethodChannels(payload: ChannelPayload) {
        methodChannelHandlers.forEach { (t, u) ->
            u.destroy(payload)
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        methodChannelHandlers.values.forEach {
            it.onAttachedToActivity(binding)
        }
        eventChannelHandlers.values.forEach {
            it.onAttachedToActivity(binding)
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        methodChannelHandlers.values.forEach {
            it.onDetachedFromActivityForConfigChanges()
        }
        eventChannelHandlers.values.forEach {
            it.onDetachedFromActivityForConfigChanges()
        }
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        methodChannelHandlers.values.forEach {
            it.onReattachedToActivityForConfigChanges(binding)
        }
        eventChannelHandlers.values.forEach {
            it.onReattachedToActivityForConfigChanges(binding)
        }
    }

    override fun onDetachedFromActivity() {
        methodChannelHandlers.values.forEach {
            it.onDetachedFromActivity()
        }
        eventChannelHandlers.values.forEach {
            it.onDetachedFromActivity()
        }
    }
}