package com.sabiantech.sabian_native_common.channels.methods.photo;

public class PhotoConfig {
    public String galleryAlbumName;
    public int galleryMaximumPhotos = 10;

    public boolean galleryShowCamera = false;

    public boolean galleryAllowMultiple = true;

    public String galleryToolBarTitle = null;

    public String galleryPrimaryColor;

    public String galleryPrimaryDarkColor;

    public boolean canProcessPermissions = true;

    @Override
    public String toString() {
        return "PhotoConfig{" +
                "galleryAlbumName='" + galleryAlbumName + '\'' +
                ", galleryMaximumPhotos=" + galleryMaximumPhotos +
                ", galleryShowCamera=" + galleryShowCamera +
                ", galleryAllowMultiple=" + galleryAllowMultiple +
                ", galleryToolBarTitle='" + galleryToolBarTitle + '\'' +
                ", galleryPrimaryColor='" + galleryPrimaryColor + '\'' +
                ", galleryPrimaryDarkColor='" + galleryPrimaryDarkColor + '\'' +
                ", canProcessPermissions=" + canProcessPermissions +
                '}';
    }
}
