package com.sabiantech.sabian_native_common.channels

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger

data class ChannelPayload(val context: Context, val messenger: BinaryMessenger)