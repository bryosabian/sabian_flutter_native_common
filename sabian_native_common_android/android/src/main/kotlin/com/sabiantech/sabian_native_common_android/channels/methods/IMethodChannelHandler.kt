package com.sabiantech.sabian_native_common_android.channels.methods

interface IMethodChannelHandler {
    fun execute(payload: MethodChannelPayload)
}