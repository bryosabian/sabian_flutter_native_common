package com.sabiantech.sabian_native_common_android.structures;

import java.util.ArrayList;

public class SabianException extends Exception {

    public static final int DB_ERROR_CODE = 101;
    public static final int USER_ERROR_CODE = 102;
    public static final int SYSTEM_ERROR_CODE = 103;

    private int errorCode = SYSTEM_ERROR_CODE;
    private String title;
    private transient ArrayList<ResponseAction> actions;

    public SabianException(Throwable cause) {
        super(cause);
        if (cause instanceof SabianException) {
            copyFrom((SabianException) cause);
        }
    }

    public SabianException(String message) {
        super(message);
    }

    public SabianException(String title, String message) {
        this(message);
        this.title = title;
    }

    public SabianException(String message, int errorCode) {
        this(message);
        this.errorCode = errorCode;
    }

    public SabianException(String title, String message, int errorCode) {
        super(message);
        this.errorCode = errorCode;
        this.title = title;
    }

    public int getErrorCode() {
        return errorCode;
    }

    public String getTitle() {
        if (title == null)
            return "";
        return title;
    }

    public boolean hasTitle() {
        return title != null && !title.isEmpty() && !title.trim().equals("");
    }

    public SabianException addAction(ResponseAction action) {
        if (actions == null)
            actions = new ArrayList<>();
        actions.add(action);
        return this;
    }

    public SabianException setActions(ArrayList<ResponseAction> actions) {
        this.actions = actions;
        return this;
    }

    public boolean hasActions() {
        return actions != null && actions.size() > 0;
    }

    public ArrayList<ResponseAction> getActions() {
        return actions;
    }

    public void copyFrom(SabianException other) {
        this.errorCode = other.errorCode;
        this.title = other.title;
        this.actions = other.actions;
    }


}