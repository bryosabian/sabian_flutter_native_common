package com.sabiantech.sabian_native_common.channels.events

import io.flutter.plugin.common.BinaryMessenger

data class EventChannelPayload(val channelName: String, val messenger: BinaryMessenger)