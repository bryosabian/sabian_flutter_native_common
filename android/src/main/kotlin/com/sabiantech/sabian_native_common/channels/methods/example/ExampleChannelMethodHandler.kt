package com.sabiantech.sabian_native_common.channels.methods.example

import com.sabiantech.sabian_native_common.channels.methods.IMethodChannelHandler
import com.sabiantech.sabian_native_common.channels.methods.MethodChannelPayload
import com.sabiantech.sabian_native_common.events.LoaderEvent
import com.sabiantech.sabian_native_common.structures.Loader

class ExampleChannelMethodHandler : IMethodChannelHandler {
    override fun execute(payload: MethodChannelPayload) {
        payload.result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }

}