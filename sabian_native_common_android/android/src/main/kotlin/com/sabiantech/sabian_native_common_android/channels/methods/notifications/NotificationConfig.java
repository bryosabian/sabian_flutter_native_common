package com.sabiantech.sabian_native_common_android.channels.methods.notifications;

import java.util.List;

public class NotificationConfig {
    public String title;

    public String message;

    public List<String> actions;

    public boolean showAsProgress = false;

    public int ID;

    public String channel;

    public boolean hasSound = true;

    public boolean canVibrate = true;

    public boolean isBig = true;

    public int progress;

    public boolean canProcessPermissions = true;
}
