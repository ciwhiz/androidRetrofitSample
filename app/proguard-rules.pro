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

### start gson
## Gson uses generic type information stored in a class file when working with fields. Proguard
## removes such information by default, so configure it to keep all of it.
#-keepattributes Signature
#
## For using GSON @Expose annotation
#-keepattributes *Annotation*
#
## Gson specific classes
#-dontwarn sun.misc.**
#
## Prevent proguard from stripping interface information from TypeAdapterFactory,
## JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
#-keep class * implements com.google.gson.TypeAdapterFactory
#-keep class * implements com.google.gson.JsonSerializer
#-keep class * implements com.google.gson.JsonDeserializer
### end gson
#
## Retain generated classes that end in the suffix
#-keepnames class **_GsonTypeAdapter
#
## Prevent obfuscation of types which use @GenerateTypeAdapter since the simple name
## is used to reflectively look up the generated adapter.
#-keepnames @com.ryanharter.auto.value.gson.GenerateTypeAdapter class *
#
#-keep class com.lgeha.nuts.BuildConfig { *; }
#
#
#-dontwarn android.**
#-keep class android.** { *; }
#
#-keep class sun.misc.Unsafe { *; }
#-keep class com.google.gson.** { *; }
#-keep class io.reactivex.** { *; }
#-keep class timber.log.** { *; }
#-keep class com.bumptech.glide.** { *; }
#-keep class okhttp3.** { *; }
#-keep class retrofit2.** { *; }
#-keep class okio.** { *; }
#-keep class com.philips.** { *; }
#
## kotlinx.serialization
## Keep `Companion` object fields of serializable classes.
## This avoids serializer lookup through `getDeclaredClasses` as done for named companion objects.
#-if @kotlinx.serialization.Serializable class **
#-keepclassmembers class <1> {
#    static <1>$Companion Companion;
#}
#
## Keep `serializer()` on companion objects (both default and named) of serializable classes.
#-if @kotlinx.serialization.Serializable class ** {
#    static **$* *;
#}
#-keepclassmembers class <2>$<3> {
#    kotlinx.serialization.KSerializer serializer(...);
#}
#
## Keep `INSTANCE.serializer()` of serializable objects.
#-if @kotlinx.serialization.Serializable class ** {
#    public static ** INSTANCE;
#}
#-keepclassmembers class <1> {
#    public static <1> INSTANCE;
#    kotlinx.serialization.KSerializer serializer(...);
#}
#
## @Serializable and @Polymorphic are used at runtime for polymorphic serialization.
#-keepattributes RuntimeVisibleAnnotations,AnnotationDefault
#
## Don't print notes about potential mistakes or omissions in the configuration for kotlinx-serialization classes
## See also https://github.com/Kotlin/kotlinx.serialization/issues/1900
#-dontnote kotlinx.serialization.**
#
## Serialization core uses `java.lang.ClassValue` for caching inside these specified classes.
## If there is no `java.lang.ClassValue` (for example, in Android), then R8/ProGuard will print a warning.
## However, since in this case they will not be used, we can disable these warnings
#-dontwarn kotlinx.serialization.internal.ClassValueWrapper
#-dontwarn kotlinx.serialization.internal.ParametrizedClassValueWrapper
#
## kotlinx.corutine
## ServiceLoader support
#-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
#-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}
#-keepnames class kotlinx.coroutines.android.AndroidExceptionPreHandler {}
#-keepnames class kotlinx.coroutines.android.AndroidDispatcherFactory {}
#
## Most of volatile fields are updated with AFU and should not be mangled
#-keepclassmembernames class kotlinx.** {
#    volatile <fields>;
#}
#
## Same story for the standard library SafeContinuation that also uses AtomicReferenceFieldUpdater
#-keepclassmembernames class kotlin.coroutines.SafeContinuation {
#    volatile <fields>;
#}
#
## Crahslytics start #
#-keepattributes *Annotation*
#-keepattributes SourceFile,LineNumberTable
#-keep public class * extends java.lang.Exception
#
#-keep class com.crashlytics.** { *; }
#-dontwarn com.crashlytics.**
## Crahslytics end #
#
#
#-keepclassmembers class * extends java.lang.Enum {
#    <fields>;
#    public static **[] values();
#    public static ** valueOf(java.lang.String);
#}

#-keep class com.sho.testproguard.model.** { *; }
#-keep class com.sho.testproguard.** { *; }
#-keep class com.sho.testproguard.ActionWhiteListSpecData.** { *; }