# ------------------------------
# 🔥 ADD THESE FOR WEBVIEW & VIMEO
# ------------------------------

# Keep JavaScript interfaces
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Keep WebView related classes
-keep class android.webkit.** { *; }
-dontwarn android.webkit.**

# Keep Vimeo player related JavaScript
-keepattributes JavascriptInterface
-keepattributes *Annotations*

# Keep all HTML/JS related classes
-keep class com.android.org.chromium.** { *; }
-dontwarn com.android.org.chromium.**

# Keep Chrome custom tabs
-keep class androidx.browser.** { *; }

# Keep Vimeo URLs and patterns
-keep class com.vimeo.** { *; }

# Ensure webview settings are kept
-keep class android.webkit.WebView {
    public *;
    protected *;
}

# Keep all classes related to networking (important for Vimeo)
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**

# Keep JSR 305 annotations
-dontwarn javax.annotation.**

# Keep all native method names
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep our VimeoPlayerScreen class
-keep class com.org.fitamplify.VimeoPlayerScreen** { *; }