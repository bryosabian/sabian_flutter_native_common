package com.sabiantech.sabian_native_common.utilities.media

import android.graphics.Bitmap
import android.net.Uri
import java.io.File

data class MediaEvent(val uri: Uri, val bitmap: Bitmap?, val file: File?)