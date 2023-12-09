package com.sabiantech.sabian_native_common_android.utilities.media

import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe
import org.greenrobot.eventbus.ThreadMode

class MediaHandler {

    @Subscribe(threadMode = ThreadMode.MAIN)
    fun onMediaEvent(event: MediaEvent) {

    }


    fun register() {
        EventBus.getDefault().register(this)
    }

    fun unRegister() {
        EventBus.getDefault().unregister(this)
    }
}