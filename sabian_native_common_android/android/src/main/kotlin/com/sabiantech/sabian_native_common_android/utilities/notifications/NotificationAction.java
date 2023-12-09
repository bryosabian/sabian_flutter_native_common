package com.sabiantech.sabian_native_common_android.utilities.notifications;

import android.app.PendingIntent;

public class NotificationAction {

    private int icon;

    private String text;

    private PendingIntent pendingIntent;

    public NotificationAction(int icon, String text, PendingIntent pendingIntent) {
        this.icon = icon;
        this.text = text;
        this.pendingIntent = pendingIntent;
    }

    public int getIcon() {
        return icon;
    }

    public String getText() {
        return text;
    }

    public PendingIntent getPendingIntent() {
        return pendingIntent;
    }
}
