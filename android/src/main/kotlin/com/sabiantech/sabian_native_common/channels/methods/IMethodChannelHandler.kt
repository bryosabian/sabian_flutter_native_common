package com.sabiantech.sabian_native_common.channels.methods

interface IMethodChannelHandler {
    fun execute(payload: MethodChannelPayload)
}