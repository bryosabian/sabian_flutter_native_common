package com.sabiantech.sabian_native_common.utilities.notifications;

import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;

import androidx.annotation.DrawableRes;
import androidx.core.app.NotificationCompat;


import com.sabiantech.sabian_native_common.Config;
import com.sabiantech.sabian_native_common.System;
import com.sabiantech.sabian_native_common.utilities.Utils;

import java.util.ArrayList;
import java.util.Date;

import io.flutter.embedding.android.FlutterActivity;

public class Notifier {
    public static final @DrawableRes
    int NOTIFICATION_ICON = Config.NOTIFICATION_ICON;
    private NotificationManager notificationManager;
    private NotificationCompat.Builder notBuilder;
    private int id;
    private String title;
    private String subTitle;
    private String buttonOkText;
    private String buttonCancelText;
    private Context context;
    private boolean showCurrentDate = false;
    private int priority = NotificationCompat.PRIORITY_DEFAULT;
    private Class<?> activityClass = null;
    private boolean isBig;
    private Intent intent;
    private String channelID = null;

    private boolean hasSound = true;

    private boolean hasVibrate = true;

    public Notifier setHasVibrate(boolean hasVibrate) {
        this.hasVibrate = hasVibrate;
        return this;
    }

    public Notifier setHasSound(boolean hasSound) {
        this.hasSound = hasSound;
        return this;
    }

    public boolean isHasSound() {
        return hasSound;
    }

    public boolean isHasVibrate() {
        return hasVibrate;
    }

    public String getChannelID() {
        return channelID;
    }

    public Notifier setChannelID(String channelID) {
        this.channelID = channelID;
        return this;
    }

    private Notifier() {
        this.activityClass = FlutterActivity.class;
    }

    public Notifier(Context context, int id) {
        this();
        this.id = id;
        this.context = context;
        notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
    }

    public Notifier(Context context, int id, NotificationManager manager) {
        this();
        this.id = id;
        notificationManager = manager;
        this.context = context;
    }

    public Intent getIntent() {
        return intent;
    }

    public Notifier setIntent(Intent intent) {
        this.intent = intent;
        return this;
    }

    public Notifier setPriority(int priority) {
        this.priority = priority;
        return this;
    }

    public Notifier setBig(boolean big) {
        isBig = big;
        return this;
    }

    public Notifier setActivityClass(Class<?> activityClass) {
        this.activityClass = activityClass;
        return this;
    }

    public void showNotification() {
        notBuilder = getNotBuilder();
        setIntents();
        notificationManager.notify(id, notBuilder.build());
    }

    public void showBigNotification() {
        notBuilder = getNotBuilder();
        setIntents();
        NotificationCompat.BigTextStyle bigTextStyle = new NotificationCompat.BigTextStyle();
        String currDate = new Date().toString();
        String message = (isShowCurrentDate()) ? subTitle += "\n\n" + currDate : subTitle;
        bigTextStyle.setBigContentTitle(title).bigText(message);
        notBuilder.setStyle(bigTextStyle);
        setIntents();
        notificationManager.notify(id, notBuilder.build());
    }

    public void showActionNotification(ArrayList<NotificationAction> actions) {
        notBuilder = getNotBuilder();
        NotificationCompat.BigTextStyle bigTextStyle = new NotificationCompat.BigTextStyle();
        String currDate = new Date().toString();
        String message = (isShowCurrentDate()) ? subTitle += "\n\n" + currDate : subTitle;
        bigTextStyle.setBigContentTitle(title).bigText(message);
        notBuilder.setStyle(bigTextStyle);
        setIntents();
        if (isNotificationActionEnabled())
            for (NotificationAction action : actions) {
                PendingIntent intent = action.getPendingIntent();
                notBuilder.addAction(action.getIcon(), action.getText(), intent);
            }
        notificationManager.notify(id, notBuilder.build());
    }

    /**
     * Shows an indeterminate notification progress
     *
     * @param withSound
     */
    public void showProgressNotification(Boolean withSound) {
        getNotBuilder();
        notBuilder.setContentTitle(title).setContentText(subTitle);
        if (withSound)
            notBuilder.setSound(System.getDefaultNotificationSound());
        notBuilder.setProgress(0, 0, true);
        notificationManager.notify(id, notBuilder.build());
    }

    /**
     * Shows a non indeterminate notification
     *
     * @param progress
     */
    public void showProgressNotification(int progress) {
        getNotBuilder();
        notBuilder.setContentTitle(title).setContentText(subTitle);
        notBuilder.setSound(null);
        notBuilder.setProgress(100, progress, false);
        notificationManager.notify(id, notBuilder.build());
    }

    private NotificationCompat.Builder getNotBuilder() {
        String cID = "";
        if (!Utils.Strings.isStringEmpty(channelID)) {
            cID = channelID;
        } else {
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                cID = NotificationChannel.createImportantChannel(context);
            }
        }
        notBuilder = new NotificationCompat.Builder(context, cID);

        notBuilder.setContentTitle(title).setContentText(subTitle);

        if (hasSound)
            notBuilder.setSound(System.getDefaultNotificationSound());
        else
            notBuilder.setSound(null);

        if (hasVibrate)
            notBuilder.setVibrate(new long[]{500, 1000});
        else
            notBuilder.setVibrate(null);

        notBuilder.setSmallIcon(NOTIFICATION_ICON).setAutoCancel(true);

        notBuilder.setPriority(priority);

        return notBuilder;
    }


    private void setIntents() {
        try {
            Intent intent = new Intent(context, activityClass);
            if (this.intent != null)
                intent = this.intent;
            PendingIntent pendingIntent = PendingIntent.getActivity(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);
            notBuilder.setContentIntent(pendingIntent);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void removeNotification() {
        notificationManager.cancel(id);
    }

    public int getId() {
        return id;
    }

    public Notifier setId(int id) {
        this.id = id;
        return this;
    }

    public String getTitle() {
        return title;
    }

    public Notifier setTitle(String title) {
        this.title = title;
        return this;
    }

    public String getSubTitle() {
        return subTitle;
    }

    public Notifier setSubTitle(String subTitle) {
        this.subTitle = subTitle;
        return this;
    }

    public String getButtonOkText() {
        return buttonOkText;
    }

    public Notifier setButtonOkText(String buttonOkText) {
        this.buttonOkText = buttonOkText;
        return this;
    }

    public String getButtonCancelText() {
        return buttonCancelText;
    }

    public Notifier setButtonCancelText(String buttonCancelText) {
        this.buttonCancelText = buttonCancelText;
        return this;
    }

    public boolean isShowCurrentDate() {
        return showCurrentDate;
    }

    public Notifier setShowCurrentDate(boolean showCurrentDate) {
        this.showCurrentDate = showCurrentDate;
        return this;
    }

    public boolean isNotificationActionEnabled() {
        return true;
    }


    public static void notify(Context context, int id, String title, String message, boolean isBig) {
        Notifier notifier = new Notifier(context, id);
        notifier.setTitle(title).setSubTitle(message);
        if (!isBig) {
            notifier.showNotification();
        } else {
            notifier.showBigNotification();
        }
    }

    public static void notify(Context context, int id, String title, String message, ArrayList<NotificationAction> buttons) {
        Notifier notifier = new Notifier(context, id);
        notifier.setTitle(title).setSubTitle(message);
        notifier.showActionNotification(buttons);
    }

    public static void notify(Context context, int id, String title, String message, ArrayList<NotificationAction> buttons, boolean highPriority) {
        Notifier notifier = new Notifier(context, id);
        notifier.setTitle(title).setSubTitle(message);
        if (highPriority)
            notifier.setPriority(NotificationCompat.PRIORITY_HIGH);
        notifier.showActionNotification(buttons);
    }

    public static void notify(Context context, int id, String title, String message, Class<?> intentClass, ArrayList<NotificationAction> buttons, boolean highPriority) {
        Notifier notifier = new Notifier(context, id);
        notifier.setTitle(title).setSubTitle(message);
        notifier.setActivityClass(intentClass);
        if (highPriority)
            notifier.setPriority(NotificationCompat.PRIORITY_HIGH);
        notifier.showActionNotification(buttons);
    }

    public static void notify(Context context, int id, String title, String message, boolean isBig, boolean highPriority) {
        Notifier notifier = new Notifier(context, id);
        notifier.setTitle(title).setSubTitle(message);
        if (highPriority)
            notifier.setPriority(NotificationCompat.PRIORITY_HIGH);

        if (isBig)
            notifier.showBigNotification();
        else
            notifier.showNotification();

    }

    public static void notify(Context context, int id, String title, String message, Class<?> intentClass, boolean isBig, boolean highPriority) {
        Notifier notifier = new Notifier(context, id);
        notifier.setActivityClass(intentClass);
        notifier.setTitle(title).setSubTitle(message);
        if (highPriority)
            notifier.setPriority(NotificationCompat.PRIORITY_HIGH);

        if (isBig)
            notifier.showBigNotification();
        else
            notifier.showNotification();

    }


}