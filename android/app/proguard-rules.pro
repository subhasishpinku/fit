# ------------------------------
# 🔥 KEEP JSON & MODELS
# ------------------------------
-keepattributes Signature
-keepattributes *Annotation*

# Keep your model classes (CHANGE PACKAGE NAME if needed)
-keep class com.org.fitamplify.models.** { *; }

# ------------------------------
# 🔥 DIO / NETWORK
# ------------------------------
-keep class okhttp3.** { *; }
-keep class okio.** { *; }

# ------------------------------
# 🔥 JSON (org.json + gson safe)
# ------------------------------
-keep class org.json.** { *; }
-keep class com.google.gson.** { *; }

# ------------------------------
# 🔥 OPTIONAL (if using Retrofit)
# ------------------------------
-keep class retrofit2.** { *; }
-keep interface retrofit2.** { *; }