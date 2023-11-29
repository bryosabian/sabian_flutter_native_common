package com.sabiantech.sabian_native_common.structures

data class Loader(var title: String = "", var message: String = "", var isHidden: Boolean = false) : IMappable {
    override val toMap: Map<String, Any>
        get() = mapOf("title" to title, "message" to message, "isHidden" to isHidden)
}