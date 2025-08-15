
# Android Signing (Release)

1) Generate a keystore (run locally once):
```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
2) Base64 the keystore and add as GitHub secret:
```bash
base64 upload-keystore.jks > upload-keystore.jks.base64
# Add the content as secret ANDROID_KEYSTORE_BASE64
```
3) Add these GitHub Secrets:
- ANDROID_KEYSTORE_BASE64
- KEYSTORE_PASSWORD
- KEY_PASSWORD
- KEY_ALIAS (e.g., upload)

4) The workflow `.github/workflows/flutter_android_release.yml` will produce a signed `app-release.apk`.
