package com.sabiantech.sabian_native_common_android;

import android.content.Context;

import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Environment;

import org.joda.time.DateTime;

import java.io.File;


/**
 * Created by Brian Sabana on 08/04/2018.
 */
public class System {

    private static final String ENVIRONMENT_DIRECTORY = "Uwanjani";


    private static Uri defaultNotificationSound;


    /**
     * Gets default photo name with full path and extension
     *
     * @param context
     * @return
     */
    public static String getDefaultPhotoFileName(Context context) {
        return getPhotoFileName(context, java.lang.System.currentTimeMillis() + "");
    }


    /**
     * Gets the file name with full path and extension
     *
     * @param context
     * @param name
     * @return
     */
    public static String getPhotoFileName(Context context, String name) {
        return String.format("%s%s.%s", getPhotosDirectoryPath(context), name, "jpg");
    }


    /**
     * The photo path. Includes trailing path
     *
     * @return
     */
    public static String getPhotosDirectoryPath(Context context) {
        String photosDir = getDirectoryPath(context, "Photos");
        return photosDir;
    }


    /**
     * The video path. Includes trailing path
     *
     * @return
     */
    public static String getVideosDirectoryPath(Context context) {
        String photosDir = getDirectoryPath(context, "Videos");
        return photosDir;
    }

    /**
     * The video path. Includes trailing path
     *
     * @return
     */
    public static String getAudiosDirectoryPath(Context context) {
        String photosDir = getDirectoryPath(context, "Audios");
        return photosDir;
    }

    /**
     * The video path. Includes trailing path
     *
     * @return
     */
    public static String getFilesDirectoryPath(Context context) {
        String photosDir = getDirectoryPath(context, "Files");
        return photosDir;
    }


    /**
     * The media path. Includes trailing path
     *
     * @param context
     * @param folderName The folder name without the trailing path
     * @return
     */
    public static String getDirectoryPath(Context context, String folderName) {
        String mediaDir = context.getExternalFilesDir(ENVIRONMENT_DIRECTORY) + "/" + folderName + "/";
        File newDir = new File(mediaDir);
        if (!newDir.exists())
            newDir.mkdirs();
        return mediaDir;
    }


    /**
     * Gets default photo name with full path and extension
     *
     * @param context
     * @return
     */
    public static String getDefaultVideoFileName(Context context) {
        return getVideoFileName(context, DateTime.now().toString("yyyy-MM-dd-HH-mm-ss"));
    }

    /**
     * Gets the file name with full path and extension
     *
     * @param context
     * @param name
     * @return
     */
    public static String getVideoFileName(Context context, String name) {
        return String.format("%s%s.%s", getVideosDirectoryPath(context), name, "mp4");
    }

    public static String getMainExternalDirectory(Context context) {
        String photosDir = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES) + "/Uwanjani/";
        File newDir = new File(photosDir);
        if (!newDir.exists())
            newDir.mkdirs();
        return photosDir;
    }

    public static String getMainMediaExternalDirectory(Context context) {
        String mediaDir = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES) + "/Uwanjani/Media/";
        File newDir = new File(mediaDir);
        if (!newDir.exists())
            newDir.mkdirs();
        return mediaDir;
    }


    /**
     * The notification uri
     *
     * @return
     */
    public static Uri getDefaultNotificationSound() {
        if (defaultNotificationSound != null)
            return defaultNotificationSound;
        defaultNotificationSound = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        return defaultNotificationSound;
    }


}
