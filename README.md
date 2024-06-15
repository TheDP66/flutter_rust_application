## Iint Project

1. Update `AndroidManifest.xml` file
2. Change `namespace`, `applicationId`, & `package`
   - Find `com.example.` and replace all
3. Update `build.gradle`
4. Update `MainActivity.kt`
5. Add `proguard-rules.pro`
6. Update kotlin version
   - See newest kotlin version [here](https://kotlinlang.org/docs/releases.html#release-details)
   - Add `ext.kotlin_version = '1.9.24'` in `android/build.gradle` inside `allprojects`
   - Update `org.jetbrains.kotlin.android` version in `settings.gradle`
7. Run `flutter clean`

## path_provider

- Update `/main/AndroidManifext.xml`
- Update `/lib/main.dart` in function `initState`

## open_filex

Docs to setup open_filex [here](https://pub.dev/packages/open_filex)

## google_maps_flutter

- `dart pub add google_maps_flutter`
- Follow the instruction [here](https://pub.dev/packages/google_maps_flutter)
