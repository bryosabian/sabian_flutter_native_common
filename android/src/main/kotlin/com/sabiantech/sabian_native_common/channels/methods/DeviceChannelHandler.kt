package com.sabiantech.sabian_native_common.channels.methods

class DeviceChannelHandler : AbstractMethodChannelHandler() {
    override fun register() {
        register("getPlatformVersion", object : IMethodChannelHandler {
            override fun execute(payload: MethodChannelPayload) {
                payload.result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
        })
    }
}