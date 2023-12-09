package com.sabiantech.sabian_native_common_android.utilities;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.lang.reflect.Modifier;
import java.lang.reflect.Type;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

public class Utils {
    public static Gson getStandardGson() {
        return getStandardGson(null);
    }

    public static Gson getStandardGson(Map<Type, Object> adapters) {
        return getGson(adapters, Modifier.PRIVATE, Modifier.TRANSIENT, Modifier.STATIC);
    }

    public static Gson getGson(Map<Type, Object> adapters, int... excludeModifiers) {
        GsonBuilder builder = new GsonBuilder();
        builder.excludeFieldsWithModifiers(excludeModifiers);
        if (adapters != null) {
            Set<Map.Entry<Type, Object>> set = adapters.entrySet();
            for (Map.Entry<Type, Object> entry : set) {
                builder.registerTypeAdapter(entry.getKey(), entry.getValue());
            }
        }
        return builder.create();
    }


    public static class Strings {
        public static boolean isStringEmpty(String string) {
            return string == null || string.isEmpty();
        }

        public static boolean isStringBlankOrEmpty(String string) {
            if (isStringEmpty(string))
                return true;
            return isStringEmpty(string.trim());
        }

        public static String toLowerCase(@NonNull String value) {
            return toLowerCase(value, Locale.ROOT);
        }

        @NonNull
        public static String toLowerCase(@NonNull String value, Locale locale) {
            try {
                return value.toLowerCase(locale);
            } catch (Throwable e) {
                return value;
            }
        }

        public static String stringOrBlank(String string) {
            if (string == null)
                return "";
            return string;
        }
    }
}
