package com.sabiantech.sabian_native_common_android.utilities.media


import android.app.Activity
import android.content.ClipData
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Color
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import androidx.core.content.FileProvider
import com.esafirm.imagepicker.features.ImagePicker
import com.sabiantech.sabian_native_common_android.System
import com.sabiantech.sabian_native_common_android.channels.methods.photo.PhotoConfig
import com.sabiantech.sabian_native_common_android.extensions.toColorOrNull
import io.flutter.embedding.android.FlutterActivity
import java.io.File


/**
 * Utility class for handling photos
 * @author Brian Sabana
 */
abstract class MediaActivity : FlutterActivity() {

    private var customPictureActions: HashMap<Int, ((Uri?, File?, Bitmap?) -> Unit)> = hashMapOf()
    private var pictureActions: HashMap<Int, ((Uri, File) -> Unit)> = hashMapOf()
    private var pictureActionUri: Uri? = null
    private var pictureActionImageFile: File? = null

    private var chooseImageActionHandler: ((ArrayList<Uri>) -> Unit)? = null
    private var chooseImageWithMultiple = false


    private var chooseVideoActionHandler: ((ArrayList<Uri>) -> Unit)? = null
    private var chooseVideoWithMultiple = false


    fun takePicture(resCode: Int, picAction: (Uri, File) -> Unit, onError: ((Throwable) -> Unit)? = null) {

        val i = Intent("android.media.action.IMAGE_CAPTURE")


        pictureActionImageFile = File(
                System.getDefaultPhotoFileName(applicationContext)
        )

        /**
         * Configured to support Nougat and above as well
         * Instead of using outlet.setImageUri(Uri.fromFile(pictureActionImageFile)) we use the code below
         * Changes file:// scheme to content:// scheme
         * @see https://inthecheesefactory.com/blog/how-to-share-access-to-file-with-fileprovider-on-android-nougat/en
         */
        pictureActionUri = FileProvider.getUriForFile(
                this,
                context.packageName + ".provider", pictureActionImageFile!!
        )

        /**
         * Grant permissions to the context
         * @see https://medium.com/@a1cooke/using-v4-support-library-fileprovider-and-camera-intent-a45f76879d61
         */
        val resolvedIntentActivities =
                packageManager?.queryIntentActivities(i, PackageManager.MATCH_DEFAULT_ONLY)
        resolvedIntentActivities?.forEach { resolvedIntentInfo ->
            val packageName = resolvedIntentInfo.activityInfo.packageName
            grantUriPermission(
                    packageName,
                    pictureActionUri,
                    Intent.FLAG_GRANT_WRITE_URI_PERMISSION or Intent.FLAG_GRANT_READ_URI_PERMISSION
            )
        }

        i.putExtra(MediaStore.EXTRA_OUTPUT, pictureActionUri)

        if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.LOLLIPOP) {
            i.clipData = ClipData.newRawUri("", pictureActionUri)
            i.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION or Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }

        pictureActions[resCode] = picAction

        startActivityForResult(i, resCode)

    }


    fun choosePicture(
            picAction: (ArrayList<Uri>) -> Unit,
            config: PhotoConfig?, onError: ((Throwable) -> Unit)? = null
    ) {
        val allowMultiple = config?.galleryAllowMultiple ?: true

        val maximumPhotos = config?.galleryMaximumPhotos ?: 10



        this.chooseImageActionHandler = picAction
        this.chooseImageWithMultiple = allowMultiple


        val builder = ImagePicker.create(this)
                .folderMode(true) // folder mode (false by default)
                .toolbarFolderTitle(config?.galleryToolBarTitle
                        ?: "Attach Photos") // folder selection title
                .toolbarImageTitle(config?.galleryToolBarTitle
                        ?: "Select Photo") // image selection title
                .toolbarArrowColor(Color.WHITE) // Toolbar 'up' arrow color
                .limit(maximumPhotos) // max images can be selected (99 by default)
                .showCamera(config?.galleryShowCamera
                        ?: false) // show camera or not (true by default)
                .imageFullDirectory(System.getPhotosDirectoryPath(applicationContext))
                // must inherit ef_BaseTheme. please refer to sample
                .enableLog(false) // disabling log
        if (allowMultiple)
            builder.multi()
        else
            builder.single()

        config?.galleryPrimaryColor?.toColorOrNull()?.let {
            builder.primaryColor(it)
        }
        config?.galleryPrimaryDarkColor?.toColorOrNull()?.let {
            builder.primaryDarkColor(it)
        }

        builder.start()

    }


    fun chooseVideo(
            videoAction: (ArrayList<Uri>) -> Unit,
            allowMultiple: Boolean = false,
            maximumVideos: Int = 1, onError: ((Throwable) -> Unit)? = null
    ) {


        this.chooseVideoActionHandler = videoAction
        this.chooseVideoWithMultiple = allowMultiple
        val builder = ImagePicker.create(this)
                .folderMode(true) // folder mode (false by default)
                .toolbarFolderTitle("Attach Video") // folder selection title
                .toolbarImageTitle("Tap to Select") // image selection title
                .toolbarArrowColor(Color.WHITE) // Toolbar 'up' arrow color
                .limit(maximumVideos) // max images can be selected (99 by default)
                .includeVideo(true)
                .onlyVideo(true)
                .showCamera(false) // show camera or not (true by default)
                .imageFullDirectory(System.getVideosDirectoryPath(applicationContext))
                // must inherit ef_BaseTheme. please refer to sample
                .enableLog(false) // disabling log
        if (allowMultiple)
            builder.multi()
        else
            builder.single()
        builder.start()


    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == Activity.RESULT_OK) {
            if (pictureActions.containsKey(requestCode)) {
                pictureActions[requestCode]?.invoke(pictureActionUri!!, pictureActionImageFile!!)
                return
            }
        }

        if (ImagePicker.shouldHandle(requestCode, resultCode, data)) {
            val images = ImagePicker.getImages(data)
            val imageList = arrayListOf<Uri>()
            for (image in images) {
                val uri = Uri.fromFile(File(image.path))
                imageList.add(uri)
            }
            chooseImageActionHandler?.invoke(imageList)
            chooseVideoActionHandler?.invoke(imageList)
        }
    }


    override fun onDestroy() {
        customPictureActions.clear()
        pictureActions.clear()
        chooseImageActionHandler = null
        chooseVideoActionHandler = null
        pictureActionImageFile = null
        super.onDestroy()
    }

}