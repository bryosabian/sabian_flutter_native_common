package com.sabiantech.sabian_native_common.channels.methods

import com.sabiantech.sabian_native_common.channels.methods.example.ExampleChannelMethodHandler

class ExampleChannelHandler : AbstractMethodChannelHandler() {
    override fun register() {
        register("getPlatformVersion", ExampleChannelMethodHandler())
    }
}