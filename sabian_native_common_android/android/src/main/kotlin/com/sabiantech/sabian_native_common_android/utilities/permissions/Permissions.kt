package com.sabiantech.sabian_native_common_android.utilities.permissions

import android.Manifest
import android.content.Context
import android.os.Build
import com.karumi.dexter.Dexter
import com.karumi.dexter.MultiplePermissionsReport
import com.karumi.dexter.PermissionToken
import com.karumi.dexter.listener.DexterError
import com.karumi.dexter.listener.PermissionRequest
import com.karumi.dexter.listener.multi.MultiplePermissionsListener
import com.sabiantech.sabian_native_common_android.structures.SabianException


class Permissions(private val context: Context) {



    fun request(
            permissions: Array<String>,
            onProceed: (PermissionRationale) -> Unit,
            allMandatory: Boolean = true,
            onError: ((Exception) -> Unit)? = null
    ) {
        val rationale = PermissionRationale(permissions, allMandatory)
        request(rationale, onProceed, onError)
    }

    fun request(
            rationale: PermissionRationale,
            onProceed: (PermissionRationale) -> Unit,
            onError: ((Exception) -> Unit)? = null
    ) {
        if (rationale.isEmpty) {
            onProceed.invoke(rationale)
            return
        }
        rationale.onRequested = onProceed
        rationale.onError = onError
        run(rationale)

    }

    private fun run(rationale: PermissionRationale) {
        val permissions: Array<String> = rationale.permissions
        Dexter.withContext(context)
                .withPermissions(*permissions)
                .withListener(object : MultiplePermissionsListener {
                    override fun onPermissionsChecked(report: MultiplePermissionsReport) {
                        try {
                            val newRationale = PermissionRationale.shallowCopy(rationale)
                            newRationale.isAnyDeniedPermanently = report.isAnyPermissionPermanentlyDenied
                            val granted = ArrayList<String>()
                            val denied = ArrayList<String>()
                            val grantedResponses = report.grantedPermissionResponses
                            val deniedResponses = report.deniedPermissionResponses
                            if (!grantedResponses.isNullOrEmpty()) {
                                for (response in grantedResponses) {
                                    granted.add(response.permissionName)
                                }
                            }
                            if (!deniedResponses.isNullOrEmpty()) {
                                for (response in deniedResponses) {
                                    denied.add(response.permissionName)
                                }
                            }
                            newRationale.accepted = granted
                            newRationale.denied = denied
                            rationale.onRequested?.invoke(newRationale)
                        } catch (e: java.lang.Exception) {
                            rationale.onError?.invoke(e)
                        }
                    }

                    override fun onPermissionRationaleShouldBeShown(list: List<PermissionRequest>, permissionToken: PermissionToken) {
                        try {
                            permissionToken.continuePermissionRequest()
                        } catch (e: java.lang.Exception) {
                            rationale.onError?.invoke(e)
                        }
                    }
                })
                .withErrorListener { error: DexterError -> rationale.onError?.invoke(SabianException(error.toString())) }
                .onSameThread()
                .check()
    }

    fun proceedIfGranted(
            permissions: Array<String>,
            onProceed: (PermissionRationale) -> Unit, onError: ((Exception) -> Unit)? = null
    ) {
        request(permissions, onProceed, true, onError)
    }

    fun proceedIfNotificationPermissionsGranted(onProceed: (PermissionRationale) -> Unit, onError: ((Exception) -> Unit)? = null) {
        proceedIfGranted(notificationPermissions.toTypedArray(), onProceed, onError)
    }

    fun proceedIfFilePermissionsGranted(
            onProceed: (PermissionRationale) -> Unit, onError: ((Exception) -> Unit)? = null
    ) {
        proceedIfGranted(filePermissions.toTypedArray(), onProceed, onError)
    }

    fun proceedIfPhotoPermissionsGranted(
            onProceed: (PermissionRationale) -> Unit,
            onError: ((Exception) -> Unit)? = null
    ) {
        proceedIfGranted(photoPermissions.toTypedArray(), onProceed, onError)
    }


    fun proceedIfLocationPermissionsGranted(
            onProceed: (PermissionRationale) -> Unit, onError: ((Exception) -> Unit)? = null
    ) {
        proceedIfGranted(locationPermissions.toTypedArray(), onProceed, onError)
    }

    fun proceedIfNeededPermissionsGranted(
            onProceed: (PermissionRationale) -> Unit, onError: ((Exception) -> Unit)? = null
    ) {
        proceedIfGranted(neededPermissions.toTypedArray(), onProceed, onError)
    }


    val neededPermissions: List<String> by lazy {
        val permissions = mutableListOf<String>()
        permissions += locationPermissions
        permissions += filePermissions
        permissions += notificationPermissions
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            permissions += Manifest.permission.ACTIVITY_RECOGNITION
        }
        permissions
    }


    companion object {

        const val PERMISSIONS_ERROR_CODE = "PermissionsError"

        @JvmStatic
        val barcodePermissions: List<String>
            get() {
                val permissions = mutableListOf(
                        Manifest.permission.CAMERA
                )
                permissions += filePermissions
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    permissions += Manifest.permission.READ_MEDIA_IMAGES
                }
                return permissions
            }

        @JvmStatic
        val photoPermissions: List<String>
            get() {
                val permissions = mutableListOf(
                        Manifest.permission.CAMERA
                )
                permissions += filePermissions
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    permissions += Manifest.permission.READ_MEDIA_IMAGES
                    permissions += audioPermissions
                }
                return permissions
            }


        @JvmStatic
        val audioPermissions: List<String>
            get() {
                val permissions = mutableListOf(Manifest.permission.RECORD_AUDIO)
                permissions += filePermissions
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    permissions += Manifest.permission.READ_MEDIA_AUDIO
                }
                return permissions
            }


        @JvmStatic
        val videoPermissions: List<String>
            get() {
                val permissions = mutableListOf(Manifest.permission.CAMERA)
                permissions += filePermissions
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    permissions += Manifest.permission.READ_MEDIA_VIDEO
                }
                return permissions
            }

        @JvmStatic
        val filePermissions: List<String> by lazy {
            val permissions = mutableListOf<String>()
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) {
                permissions += Manifest.permission.WRITE_EXTERNAL_STORAGE
                permissions += Manifest.permission.READ_EXTERNAL_STORAGE
            }
            permissions
        }


        @JvmStatic
        val locationPermissions: List<String> by lazy {
            listOf(
                    Manifest.permission.ACCESS_FINE_LOCATION,
                    Manifest.permission.ACCESS_COARSE_LOCATION
            )
        }

        @JvmStatic
        val notificationPermissions: List<String> by lazy {
            val list = arrayListOf<String>()
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                list.add(Manifest.permission.POST_NOTIFICATIONS)
            }
            list
        }
    }
}