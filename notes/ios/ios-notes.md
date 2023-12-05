# iOS Notes

## DWARF_DSYM_FOLDER_PATH

```console
xcodebuild -workspace ./ios/Runner.xcworkspace \
  -configuration Release-dev \
  -scheme dev \
  -showBuildSettings \
  | grep DWARF_DSYM_FOLDER_PATH
```
