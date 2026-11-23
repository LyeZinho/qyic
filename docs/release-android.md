# Releasing the Android app

The Android client lives in [`mobile/android/`](../mobile/android/). The
application id is `com.qyic.app`. It is fixed for the lifetime of the Play
listing, so change it only before the first upload.

## One-time: create the upload key

Keep the keystore and its passwords outside the repository and back them up.
Losing the key means losing the ability to update the app.

```bash
keytool -genkey -v -keystore ~/keys/qyic-release.jks -keyalg RSA -keysize 2048 \
  -validity 10000 -alias qyic
```

Then copy [`mobile/android/key.properties.example`](../mobile/android/key.properties.example)
to `mobile/android/key.properties` and fill in the passwords and the absolute
path to the keystore. `key.properties` and `*.jks` are git-ignored.

## Building

A release build without `key.properties` fails on purpose, so an unsigned or
debug-signed build cannot be shipped by mistake.

```bash
cd mobile
flutter build appbundle --release   # Play Store upload (build/app/outputs/bundle/release/)
flutter build apk --release         # sideload / testing (build/app/outputs/flutter-apk/)
```

Bump the version in `mobile/pubspec.yaml` (`version: 0.1.0+1`, the part after
`+` is the Android `versionCode`). Every upload needs a higher `versionCode`.

## Assets

- Launcher icon: adaptive icon in `mobile/android/app/src/main/res/` (lime
  bolt on the Qyic background `#15141F`). Legacy PNGs are the fallback for
  Android 7.x.
- Play Store icon: `mobile/android/store/play-store-icon-512.png`.
- Splash: the same background colour as the app, so there is no white flash.

## Checks before uploading

```bash
cd mobile
flutter analyze
flutter test
flutter build appbundle --release
```
