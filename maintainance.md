# Maintainance Tasks 

- Sync [deferred_widget.dart] code periodically with [flutter/gallery's deferred_widget.dart]
  ```console
  diff --unified --color \
    lib/deferred_loading/deferred_widget.dart \
    <(curl -fsSL https://github.com/flutter/gallery/raw/main/lib/deferred_widget.dart)
  ```
- Keep syncing Platform support for [flutter_keyboard_visibility] with [config.dart]

[deferred_widget.dart]: lib/deferred_loading/deferred_widget.dart
[flutter/gallery's deferred_widget.dart]: https://github.com/flutter/gallery/blob/main/lib/deferred_widget.dart
[flutter_keyboard_visibility]: https://github.com/MisterJimson/flutter_keyboard_visibility
[config.dart]: lib/config/config.dart
