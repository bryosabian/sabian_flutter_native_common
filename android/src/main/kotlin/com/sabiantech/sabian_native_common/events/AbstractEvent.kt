package com.sabiantech.sabian_native_common.events

import io.flutter.plugin.common.EventChannel

abstract class AbstractEvent : EventChannel.StreamHandler {
    protected var eventSink: EventChannel.EventSink? = null
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    protected open fun raise(payload: Any) {
        eventSink?.let {
            it.success(payload)
        }
    }
}