package com.sabiantech.sabian_native_common_android.channels.utils

import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class ChannelHandlerActivityAwareImpl<T, A>(private val channelHandlers: HashMap<String, T>) : ActivityAware {

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        channelHandlers.values.forEach {
            if (it is ActivityAware) {
                it.onAttachedToActivity(binding)
            }
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        channelHandlers.values.forEach {
            if (it is ActivityAware) {
                it.onDetachedFromActivityForConfigChanges()
            }
        }
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        channelHandlers.values.forEach {
            if (it is ActivityAware) {
                it.onReattachedToActivityForConfigChanges(binding)
            }
        }
    }

    override fun onDetachedFromActivity() {
        channelHandlers.values.forEach {
            if (it is ActivityAware) {
                it.onDetachedFromActivity()
            }
        }
    }
}