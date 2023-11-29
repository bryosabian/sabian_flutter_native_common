package com.sabiantech.sabian_native_common.extensions

import com.sabiantech.sabian_native_common.utilities.Utils
import java.lang.reflect.Type

/**
 * Converts json to object
 * See more about reified here : [link](https://stackoverflow.com/a/45952201/4681900)
 */
@Throws(Exception::class)
inline fun <reified K> String.fromJSON(
        adapters: Map<Type, Any>? = null
): K {
    val mAdapters = hashMapOf<Type, Any>()
    if (adapters != null)
        mAdapters.putAll(adapters)
    val gson = Utils.getStandardGson(mAdapters)
    return gson.fromJson(this, K::class.java)
}

/**
 * Converts json to object or returns null
 * See more about reified here : [link](https://stackoverflow.com/a/45952201/4681900)
 */
inline fun <reified K> String.fromJSONOrNull(
        adapters: Map<Type, Any>? = null
): K? {

    return try {
        fromJSON<K>(adapters)
    } catch (e: Throwable) {
        null
    }
}