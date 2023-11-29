package com.sabiantech.sabian_native_common.utilities.notifications;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.os.Build;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import java.util.HashMap;


public class NotificationChannel {

    private final Context context;

    private final HashMap<String, String> notificationChannels = new HashMap<>();

    @RequiresApi(api = Build.VERSION_CODES.N)
    public static final ChannelDescription CHANNEL_IMPORTANT = new ChannelDescription("Ukall Notification Important Channel", "Important", "Shows in app notifications that require your attention", NotificationManager.IMPORTANCE_HIGH, true);

    @RequiresApi(api = Build.VERSION_CODES.N)
    public static final ChannelDescription CHANNEL_SILENT = new ChannelDescription("Ukall Notification Silent Channel", "Silent", "Shows silent notifications that don't require your attention", NotificationManager.IMPORTANCE_LOW, false);

    public NotificationChannel(Context context) {
        this.context = context;
    }

    /**
     * NotificationChannels are required for Notifications on O (API 26) and above.
     *
     * @param description
     * @return
     */
    @Nullable
    @RequiresApi(api = Build.VERSION_CODES.N)
    public String create(ChannelDescription description) {
        return create(description.ID, description.name, description.description, description.priority, description.canVibrate);
    }

    /**
     * @param channelId
     * @param name
     * @param description
     * @param channelImportance
     * @param channelEnableVibrate
     * @return
     */
    @Nullable
    public String create(
            String channelId,
            String name,
            String description,
            int channelImportance,
            boolean channelEnableVibrate) {


        // NotificationChannels are required for Notifications on O (API 26) and above.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

            if (notificationChannels.containsKey(channelId)) {
                return channelId;
            }

            NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);

            // The user-visible name of the channel.
            // The user-visible description of the channel.
            int channelLockScreenVisibility = Notification.VISIBILITY_PUBLIC;

            // Initializes NotificationChannel.
            android.app.NotificationChannel notificationChannel = new android.app.NotificationChannel(channelId, name, channelImportance);
            notificationChannel.setDescription(description);
            notificationChannel.enableVibration(channelEnableVibrate);
            notificationChannel.setLockscreenVisibility(channelLockScreenVisibility);

            if (!channelEnableVibrate) {
                notificationChannel.setSound(null, null);
            }

            notificationManager.createNotificationChannel(notificationChannel);
            notificationChannels.put(channelId, channelId);

            return channelId;
        } else {
            // Returns null for pre-O (26) devices.
            return null;
        }
    }

    public void delete(String channelID) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            if (notificationManager.getNotificationChannel(channelID) != null)
                notificationManager.deleteNotificationChannel(channelID);
        }
    }


    @Nullable
    public static String createSilentChannel(Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            return createChannel(context, CHANNEL_SILENT);
        }
        return null;
    }

    @Nullable
    public static String createImportantChannel(Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            return createChannel(context, CHANNEL_IMPORTANT);
        }
        return null;
    }

    @RequiresApi(api = Build.VERSION_CODES.N)
    public static String createChannel(Context context, ChannelDescription description) {
        NotificationChannel channel = new NotificationChannel(context);
        return channel.create(description);
    }


    @RequiresApi(api = Build.VERSION_CODES.N)
    public static class ChannelDescription {
        public String ID;
        public String name;
        public String description;
        public int priority;
        public boolean canVibrate;

        public ChannelDescription(String ID, String name, String description, int priority, boolean canVibrate) {
            this.ID = ID;
            this.name = name;
            this.description = description;
            this.priority = priority;
            this.canVibrate = canVibrate;
        }
    }
}
