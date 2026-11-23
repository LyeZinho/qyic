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

## Two kinds of build

- **GitHub download (sideload):** no key needed. Without `key.properties` the
  release APK is signed with the debug key. Testers install it directly, but
  the debug key is different on every machine and CI runner, so a newer APK
  will not install over an older one. Uninstall first until a stable key exists.
- **Play Store:** needs the upload key from `key.properties`, and the App Bundle
  (`.aab`) is what gets uploaded.

## Building

```bash
cd mobile
flutter build appbundle --release   # Play Store upload (build/app/outputs/bundle/release/)
flutter build apk --release         # sideload (build/app/outputs/flutter-apk/)
```

## Automated release (GitHub Actions)

[`.github/workflows/android-release.yml`](../.github/workflows/android-release.yml)
runs on every `android-v*` tag and attaches `qyic-<version>.apk` and
`qyic-<version>.aab` to that tag's GitHub release. To build an existing tag,
run the workflow manually and enter the tag. It creates the release if it does
not exist yet.

```bash
git tag -a android-v0.1.1 -m "Android 0.1.1+2" && git push origin android-v0.1.1
```

The workflow signs with the debug key (see above). To use the upload key in CI,
store the keystore as a base64 secret and write `key.properties` in the job.

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
