import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Release signing reads android/key.properties (git-ignored). See
// key.properties.example for the expected keys and docs/release-android.md.
val releaseKeystoreFile = rootProject.file("key.properties")
val releaseKeystoreProperties = Properties().apply {
    if (releaseKeystoreFile.exists()) releaseKeystoreFile.inputStream().use { load(it) }
}

// Without android/key.properties the release build is signed with the debug
// key. That is enough for APKs downloaded from GitHub (sideloading), but the
// debug key differs between machines and CI runners, so a new APK will not
// install over one signed with another key. The Play Store needs the upload
// key (see docs/release-android.md).
val releaseRequested = gradle.startParameter.taskNames.any { it.contains("Release", ignoreCase = true) }
if (releaseRequested && !releaseKeystoreFile.exists()) {
    logger.warn("No android/key.properties: signing the release build with the debug key.")
}

android {
    namespace = "com.qyic.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // java.time APIs used by flutter_local_notifications on older Android.
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // Reverse-DNS id; once a build reaches the Play Store it can never change.
        applicationId = "com.qyic.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Taken from pubspec.yaml (version: name+code).
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (releaseKeystoreFile.exists()) {
            create("release") {
                keyAlias = releaseKeystoreProperties.getProperty("keyAlias")
                keyPassword = releaseKeystoreProperties.getProperty("keyPassword")
                storeFile = rootProject.file(releaseKeystoreProperties.getProperty("storeFile"))
                storePassword = releaseKeystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.findByName("release") ?: signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
