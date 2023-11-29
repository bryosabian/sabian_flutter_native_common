package com.sabiantech.sabian_native_common.events

import com.sabiantech.sabian_native_common.structures.IMappable

abstract class AbstractMappableEvent<T : IMappable> : AbstractEvent() {
    fun raise(payload: T) {
        super.raise(payload.toMap)
    }
}