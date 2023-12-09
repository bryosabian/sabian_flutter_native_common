package com.sabiantech.sabian_native_common_android.structures;

/**
 * @since 33.1.1
 */
public class ResponseAction {
    public String title;
    public String action;
    public transient IResponseAction responseAction;

    public ResponseAction() {

    }

    public ResponseAction(String title, String action) {
        this.title = title;
        this.action = action;
    }

    public ResponseAction(String title, String action, IResponseAction responseAction) {
        this.title = title;
        this.action = action;
        this.responseAction = responseAction;
    }

    public ResponseAction(String title, IResponseAction responseAction) {
        this.title = title;
        this.responseAction = responseAction;
    }
}