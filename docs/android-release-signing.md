# Signing a RiseUp release APK

Amazon Appstore accepts release APKs only when they are signed with your own private Android certificate. The private keystore and its passwords must never be committed or shared.

## One-time setup on your Windows computer

From the project folder, run this command and choose a strong password when prompted:

```powershell
keytool -genkeypair -v -keystore android/upload-keystore.jks -alias riseup -keyalg RSA -keysize 2048 -validity 10000
```

Copy `android/key.properties.example` to `android/key.properties`, then replace the passwords with the ones you chose:

```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=riseup
storeFile=upload-keystore.jks
```

Keep both `android/upload-keystore.jks` and `android/key.properties` private and backed up securely. You need the same key to publish future updates to RiseUp.

## Build the APK

```powershell
flutter clean
flutter build apk --release
```

Upload `build/app/outputs/flutter-apk/app-release.apk` to Amazon. The project now refuses to package a release APK if the private release signing configuration is missing, preventing accidental debug-signed submissions.
