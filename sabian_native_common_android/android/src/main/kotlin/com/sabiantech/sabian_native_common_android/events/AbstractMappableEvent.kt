package com.sabiantech.sabian_native_common_android.events

import com.sabiantech.sabian_native_common_android.structures.IMappable

abstract class AbstractMappableEvent<T : IMappable> : AbstractEvent() {
    fun raise(payload: T) {
        super.raise(payload.toMap)
    }
}