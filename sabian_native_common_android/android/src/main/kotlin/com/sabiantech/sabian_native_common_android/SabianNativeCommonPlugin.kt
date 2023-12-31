package com.sabiantech.sabian_native_common

import androidx.annotation.NonNull
import com.sabiantech.sabian_native_common_android.channels.ChannelPayload
import com.sabiantech.sabian_native_common_android.channels.ChannelsManager

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger

/** SabianNativeCommonPlugin */
class SabianNativeCommonPlugin : FlutterPlugin, ActivityAware {

    private var messenger: BinaryMessenger? = null

    private val manager: ChannelsManager by lazy {
        ChannelsManager()
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.messenger = flutterPluginBinding.binaryMessenger
        val payload = ChannelPayload(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger)
        manager.setUp(payload)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        val payload = ChannelPayload(binding.applicationContext, binding.binaryMessenger)
        manager.destroy(payload)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        manager.onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        manager.onDetachedFromActivityForConfigChanges()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
       manager.onReattachedToActivityForConfigChanges(binding)
    }

    override fun onDetachedFromActivity() {
       manager.onDetachedFromActivity()
    }
}
