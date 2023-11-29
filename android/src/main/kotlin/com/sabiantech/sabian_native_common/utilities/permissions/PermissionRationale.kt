package com.sabiantech.sabian_native_common.utilities.permissions

class PermissionRationale(
        var permissions: Array<String>,
        var allMandatory: Boolean = true,
        var description: String? = null,
        var onRequested: ((PermissionRationale) -> Unit)? = null,
        var accepted: List<String>? = null,
        var denied: List<String>? = null,
        var onError: ((Exception) -> Unit)? = null,
        var areAllDenied: Boolean? = null,
        var isAnyDenied: Boolean? = null,
        var isAnyDeniedPermanently: Boolean? = null
) {
    companion object {
        fun shallowCopy(rationale: PermissionRationale): PermissionRationale {
            return PermissionRationale(rationale.permissions, rationale.allMandatory)
        }
    }


    val isEmpty: Boolean
        get() = permissions.isEmpty()

    val areAllPermissionsDenied: Boolean
        get() {
            if (areAllDenied != null)
                return areAllDenied!!
            val denied = denied ?: listOf()
            return permissions.size == denied.size
        }


    val isAnyPermissionDenied: Boolean
        get() {
            if (isAnyDenied != null)
                return isAnyDenied!!
            val denied = denied ?: listOf()
            return permissions.any {
                denied.contains(it)
            }
        }


    val isAnyPermissionAccepted: Boolean
        get() {
            if (areAllPermissionsDenied)
                return false
            val accepted = accepted ?: listOf()
            return permissions.any {
                accepted.contains(it)
            }
        }

    fun isPermissionDenied(permission: String): Boolean {
        return denied?.contains(permission) ?: false
    }

    fun isPermissionAccepted(permission: String): Boolean {
        return accepted?.contains(permission) ?: false
    }
}