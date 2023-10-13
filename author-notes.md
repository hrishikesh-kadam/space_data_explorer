# Author Notes

## TODOs

- About Page
  - Rate App for Android and iOS
  - App info link for Android
- Add Privacy Policy Page, and link it to About Page
- Fix ./tool/android/run.sh script
- Reduce gradlew build lints
- Wrap actions of AppBar
- Add zero count image placeholder
- Resolution-aware app icon image

## Theme TODOs

- Fix Text style

## Future Tasks

### iOS

- Add flavors
- Add Universal Links
- i18n - https://docs.flutter.dev/accessibility-and-localization/internationalization#localizing-for-ios-updating-the-ios-app-bundle
- Firebase - Crashlytics
- Sentry

## Code shrinking / Tree-shaking / Resource shrinking / Obfuscation / Optimization

### Android

- References:
  - https://developer.android.com/build/shrink-code
  - https://support.google.com/googleplay/android-developer/answer/9848633
- No action is needed.  
  `minifyEnabled`, `shrinkResources`, `proguardFile` already configured for `release` buildType in [`flutter.groovy`]
- No need to upload Native Debug Symbols.  
  `libapp.so` and `libflutter.so` already included in App Bundle at `/base/lib/<arch-variants>/`.  
  Adding `android.defaultConfig.ndk.debugSymbolLevel = 'FULL'` to `build.gradle` has no effect in size of the App Bundle.  
  This might only require if we have any extra Native library.
- No need to upload deobfuscation mapping files.  
  `proguard.map` already included in App Bundle at `/BUNDLE-METADATA/com.android.tools.build.obfuscation/`.

## Error Reporting Services

### Crashlytics

- ✅ Dart Debug Symbol Files
- ⬜ R8, ProGuard, and DexGuard Mapping Files

### Sentry

- ✅ Dart Debug Symbol Files, Source
- ⬜ R8, ProGuard, and DexGuard Mapping Files
- ✅ Web Source Maps

## Icons Notes

- [Android - Adding a launcher icon][]
- [Maskable icon][]
- [Android - Adaptive icons][]
- [Android - Create app icons with Image Asset Studio][]
- [Android - Add multi-density vector graphics][]
- [assets/app-icons/app-icon.png] is 192x192 version of [android/app/src/main/ic_launcher-playstore.png]

## README Notes

- Add `git clone --config core.autocrlf=false` for Windows

## Test Notes

- [How to write effective Flutter and Dart tests | Flutter Forward][]


[`flutter.groovy`]: https://github.com/flutter/flutter/blob/stable/packages/flutter_tools/gradle/src/main/groovy/flutter.groovy
[Android - Adding a launcher icon]: https://docs.flutter.dev/deployment/android#adding-a-launcher-icon
[Maskable icon]: https://web.dev/maskable-icon/
[Android - Adaptive icons]: https://developer.android.com/develop/ui/views/launch/icon_design_adaptive
[Android - Create app icons with Image Asset Studio]: https://developer.android.com/studio/write/image-asset-studio
[Android - Add multi-density vector graphics]: https://developer.android.com/studio/write/vector-asset-studio
[assets/app-icons/app-icon.png]: assets/app-icons/app-icon.png
[android/app/src/main/ic_launcher-playstore.png]: android/app/src/main/ic_launcher-playstore.png
[How to write effective Flutter and Dart tests | Flutter Forward]: https://www.youtube.com/watch?v=bHLrSliaL1Q&list=PLjxrf2q8roU3LvrdR8Hv_phLrTj0xmjnD&index=25
