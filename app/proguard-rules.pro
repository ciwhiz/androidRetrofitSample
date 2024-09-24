
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html
# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}
# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable
# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
# from web module
#-keep class com.fasterxml.uuid.*{ *; }
#-dontwarn com.fasterxml.uuid.**
#-dontwarn org.opencv.**
-keep class org.** {
    *;
}
-keep class org.chromium.** {
    *;
}
-keep public class * extends org.apache.cordova.CordovaPlugin
-keep public class * extends com.phonegap.api.Plugin
-keep class org.apache.cordova.** { *; }
-keepattributes **
-dontwarn org.**
-dontwarn com.google.**
-keep class com.lge.securitychecker.** { *; }
-keep class com.lgeha.nuts.MainLoader { *; }
-keep class com.lgeha.nuts.MainLoaderInterface { *; }
-keep class com.lgeha.nuts.LMessage { *; }
-keep class com.lgeha.nuts.npm.moduleupdate.Decompress { *; }
-keep class com.lgeha.nuts.security.MainLoader { *; }
-keep class com.lgeha.nuts.security.MainLoaderInterface { *; }
-keep class com.lgeha.nuts.security.LoadCordovaWebViewListener { *; }
-keep class com.lgeha.nuts.security.CopyAssetToLocalStorageListener { *; }
-keep class com.lgeha.nuts.security.module.SecurityModule$* {*; }
-keep class com.lgeha.nuts.security.module.SecurityModule { *; }
-keep interface com.lge.conv.thingstv.ISmartTvServiceCallbackInterface { *; }
-keep class com.lge.conv.thingstv.ISmartTvServiceCallbackInterface$Stub { *; }
-keep interface com.lge.conv.thingstv.ISmartTvServiceInterface { *; }
-keep class com.lge.conv.thingstv.ISmartTvServiceInterface$Stub { *; }
# NAVER Login SDK, see https://developers.naver.com/docs/login/android/
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn retrofit2.**
-keep public class com.nhn.android.naverlogin.** {
       public protected *;
}
# end web module
# start native module
-dontwarn com.lge.PosClusteringApi.MyPlaceEngineProvider
-dontwarn com.lgeha.nuts.npm.push.**
-dontwarn com.lgeha.nuts.npm.utility.**
-keep class com.lgeha.nuts.model.** {*;}
-keepclassmembers class * extends java.lang.Enum {
    <fields>;
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-keepclassmembers public class * extends com.lgeha.nuts.ui.dashboard.Card {
   public <init>(...);
}
## start gson
# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
-keepattributes Signature
# For using GSON @Expose annotation
-keepattributes *Annotation*
# Gson specific classes
-dontwarn sun.misc.**
# Prevent proguard from stripping interface information from TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
## end gson
# Retain generated classes that end in the suffix
-keepnames class **_GsonTypeAdapter
# Prevent obfuscation of types which use @GenerateTypeAdapter since the simple name
# is used to reflectively look up the generated adapter.
-keepnames @com.ryanharter.auto.value.gson.GenerateTypeAdapter class *
-keep class com.lgeha.nuts.BuildConfig { *; }
-dontwarn android.**
-keep class android.** { *; }
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.** { *; }
-keep class io.reactivex.** { *; }
-keep class timber.log.** { *; }
-keep class com.bumptech.glide.** { *; }
-keep class okhttp3.** { *; }
-keep class retrofit2.** { *; }
-keep class okio.** { *; }
-keep class com.philips.** { *; }
# kotlinx.serialization
# Keep `Companion` object fields of serializable classes.
# This avoids serializer lookup through `getDeclaredClasses` as done for named companion objects.
-if @kotlinx.serialization.Serializable class **
-keepclassmembers class <1> {
    static <1>$Companion Companion;
}
# Keep `serializer()` on companion objects (both default and named) of serializable classes.
-if @kotlinx.serialization.Serializable class ** {
    static **$* *;
}
-keepclassmembers class <2>$<3> {
    kotlinx.serialization.KSerializer serializer(...);
}
# Keep `INSTANCE.serializer()` of serializable objects.
-if @kotlinx.serialization.Serializable class ** {
    public static ** INSTANCE;
}
-keepclassmembers class <1> {
    public static <1> INSTANCE;
    kotlinx.serialization.KSerializer serializer(...);
}
# @Serializable and @Polymorphic are used at runtime for polymorphic serialization.
-keepattributes RuntimeVisibleAnnotations,AnnotationDefault
# Don't print notes about potential mistakes or omissions in the configuration for kotlinx-serialization classes
# See also https://github.com/Kotlin/kotlinx.serialization/issues/1900
-dontnote kotlinx.serialization.**
# Serialization core uses `java.lang.ClassValue` for caching inside these specified classes.
# If there is no `java.lang.ClassValue` (for example, in Android), then R8/ProGuard will print a warning.
# However, since in this case they will not be used, we can disable these warnings
-dontwarn kotlinx.serialization.internal.ClassValueWrapper
-dontwarn kotlinx.serialization.internal.ParametrizedClassValueWrapper
# kotlinx.corutine
# ServiceLoader support
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}
-keepnames class kotlinx.coroutines.android.AndroidExceptionPreHandler {}
-keepnames class kotlinx.coroutines.android.AndroidDispatcherFactory {}
# Most of volatile fields are updated with AFU and should not be mangled
-keepclassmembernames class kotlinx.** {
    volatile <fields>;
}
# Same story for the standard library SafeContinuation that also uses AtomicReferenceFieldUpdater
-keepclassmembernames class kotlin.coroutines.SafeContinuation {
    volatile <fields>;
}
# Crahslytics start #
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception
-keep class com.crashlytics.** { *; }
-dontwarn com.crashlytics.**
# Crahslytics end #
# Hejhome Paring SDK 라이브러리
-keep class com.goqual.hejhome.sdk.** {*;}
-dontwarn com.goqual.hejhome.sdk.**
-keep class com.goqual.base.** {*;}
-dontwarn com.goqual.base.**
# Hejhome Paring SDK 의존성 라이브러리
-keep class com.tuya.**{*;}
-dontwarn com.tuya.**
-keep class com.thingclips.**{*;}
-dontwarn com.thingclips.**
-keep class com.alibaba.fastjson.**{*;}
-dontwarn com.alibaba.fastjson.**
# Matter 라이브러리
-keep class chip.devicecontroller.** {*;}
-dontwarn chip.devicecontroller.**
# AppsFlyer
-keep class com.appsflyer.** { *; }
-keep public class com.android.installreferrer.** { *; }
-dontwarn com.appsflyer.**

#-keep class com.sho.testproguard.model.** { <fields>;}

## AGP 8 update gson setting
##---------------Begin: proguard configuration for Gson  ----------
# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
-keepattributes Signature

# For using GSON @Expose annotation
-keepattributes *Annotation*

# Gson specific classes
-dontwarn sun.misc.**
#-keep class com.google.gson.stream.** { *; }

# Application classes that will be serialized/deserialized over Gson

# Prevent proguard from stripping interface information from TypeAdapter, TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Prevent R8 from leaving Data object members always null
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# Retain generic signatures of TypeToken and its subclasses with R8 version 3.0 and higher.
-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken

#---------------End: proguard configuration for Gson  ----------

#-keep class com.sho.testproguard.model.Post {
#    <fields>;
#    public <init>(...);
#}
#-keep class com.sho.testproguard.model.Post2 {
#    <fields>;
#    public <init>(...);
#}
-keep class com.google.gson.** { *; }
-keep class android.** { *; }
-keepnames @com.ryanharter.auto.value.gson.GenerateTypeAdapter class *
-keepnames class **_GsonTypeAdapter
## start gson
# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
-keepattributes Signature

# For using GSON @Expose annotation
-keepattributes *Annotation*

# Gson specific classes
-dontwarn sun.misc.**

# Prevent proguard from stripping interface information from TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
## end gson