package com.sabiantech.sabian_native_common.channels.methods

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

data class MethodChannelPayload(val context: Context, val result: MethodChannel.Result, val call: MethodCall)