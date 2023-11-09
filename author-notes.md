# Author Notes

## TODOs

- Android add com.google.android.gms.permission.AD_ID permission
- About Page
  - Rate App for Android and iOS
  - App info link for Android
- Add Privacy Policy Page, and link it to About Page
- Reduce gradlew build lints
- Wrap actions of AppBar
- Add zero count image placeholder
- Resolution-aware app icon image
- Add scroll to top and bottom for list views
- React to RTL from Android Developer settings

## Future Tasks

### iOS

- Fix log colors
- Add flavors
- Update .vscode/launch.json
- Add Universal Links
- i18n - https://docs.flutter.dev/accessibility-and-localization/internationalization#localizing-for-ios-updating-the-ios-app-bundle
- Firebase - Crashlytics
- Sentry
- LaunchImage
- Rename the Targets

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

- [Android - Adding a launcher icon]
- [Maskable icon]
- [Android - Adaptive icons]
- [Android - Create app icons with Image Asset Studio]
- [Android - Add multi-density vector graphics]
- [assets/app-icons/app-icon.png] is 192x192 version of [android/app/src/main/ic_launcher-playstore.png]

### Steps taken to generate icons

#### Android

1. In Android Studio, right click drawable folder, select new Image Asset.
2. In Foreground layer, select appropriate Clip art, resize to 90%.
3. In Background layer, select appropriate Color.
4. In Options, choose No for Round Icon.
5. After asset generation, place ic_launcher_foreground.xml in 
   drawable-anydpi-v26 instead of drawable folder.
6. Move the colors from ic_background_foreground.xml to colors.xml.
7. Convert the ic_launcher_foreground.xml to svg format.
8. Format the xml and svg files.
9. ```bash
   cp ./android/app/src/main/ic_launcher-playstore.png \
     ./android/fastlane/prod/metadata/android/en-US/images/icon.png
   cp ./android/app/src/main/ic_launcher-playstore.png \
     ./android/fastlane/stag/metadata/android/en-US/images/icon.png
   cp ./android/app/src/main/ic_launcher-playstore.png \
     ./android/fastlane/dev/metadata/android/en-US/images/icon.png
   ```

#### Web

1. ```bash
   cp ./android/app/src/main/ic_launcher-playstore.png ./web/icons/Icon-512.png
   convert -resize 192x192 \
     ./android/app/src/main/ic_launcher-playstore.png \
     ./web/icons/Icon-192.png
   convert -resize 16x16 \
     ./android/app/src/main/ic_launcher-playstore.png \
     ./web/favicon.png
   ```
2. Open https://maskable.app/editor, select appropriate color in Background layer.
3. Upload Forground svg file.
4. Choose Padding 35%, Color strength 100%.
5. Export required file sizes.

#### iOS

1. ```bash
   convert -resize 1024x1024 \
     ./android/app/src/main/ic_launcher-playstore.png \
     ./ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
   ```
2. Open Assets.xcassets in Xcode, delete old AppIcon, create New iOS App Icon, 
   select above image.

#### Flutter

1. ```bash
   convert -resize 192x192 \
     ./android/app/src/main/ic_launcher-playstore.png \
     ./assets/app-icons/app-icon.png
   ```

## README Notes

- Add `git clone --config core.autocrlf=false` for Windows

## Test Notes

- [How to write effective Flutter and Dart tests | Flutter Forward]

## Theme Notes

- [Use themes to share colors and font styles]
- [Material 3 demo]
- [Theme (Flutter Hallowidget of the Week)]
- [MaterialStateProperties | Decoding Flutter]
- [ThemeExtensions | Decoding Flutter]
- [Deep Dive Into Flutter Theming | FlutterVikings 2022]
- [material_color_utilities]
- [dynamic_color]


[`flutter.groovy`]: https://github.com/flutter/flutter/blob/stable/packages/flutter_tools/gradle/src/main/groovy/flutter.groovy
[Android - Adding a launcher icon]: https://docs.flutter.dev/deployment/android#adding-a-launcher-icon
[Maskable icon]: https://web.dev/maskable-icon/
[Android - Adaptive icons]: https://developer.android.com/develop/ui/views/launch/icon_design_adaptive
[Android - Create app icons with Image Asset Studio]: https://developer.android.com/studio/write/image-asset-studio
[Android - Add multi-density vector graphics]: https://developer.android.com/studio/write/vector-asset-studio
[assets/app-icons/app-icon.png]: assets/app-icons/app-icon.png
[android/app/src/main/ic_launcher-playstore.png]: android/app/src/main/ic_launcher-playstore.png
[How to write effective Flutter and Dart tests | Flutter Forward]: https://www.youtube.com/watch?v=bHLrSliaL1Q&list=PLjxrf2q8roU3LvrdR8Hv_phLrTj0xmjnD&index=25
[Use themes to share colors and font styles]: https://docs.flutter.dev/cookbook/design/themes
[Material 3 demo]: https://flutter.github.io/samples/web/material_3_demo/
[Theme (Flutter Hallowidget of the Week)]: https://www.youtube.com/watch?v=oTvQDJOBXmM
[MaterialStateProperties | Decoding Flutter]: https://www.youtube.com/watch?v=CylXr3AF3uU
[ThemeExtensions | Decoding Flutter]: https://www.youtube.com/watch?v=8-szcYzFVao
[Deep Dive Into Flutter Theming | FlutterVikings 2022]: https://www.youtube.com/watch?v=V5S8wyUAeto
[material_color_utilities]: https://pub.dev/packages/material_color_utilities
[dynamic_color]: https://pub.dev/packages/dynamic_color
