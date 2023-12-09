package com.sabiantech.sabian_native_common_android.structures

data class Error(var title: String = "", var message: String = "", var isHidden: Boolean = false) : IMappable {
    override val toMap: Map<String, Any>
        get() = mapOf("title" to title, "message" to message, "isHidden" to isHidden)
}

fun SabianException.toError(): Error {
    return Error(title ?: "Error", message ?: "", isHidden = false)
}

