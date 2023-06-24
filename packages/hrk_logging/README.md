<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Colorful logs by HRK

## Features

- Colorful Logs
- Emojis
- Support for log.debug()
- Root Logger is set to `Level.OFF` in Dart and Flutter Test  
  See [lib/src/helper/helper_non_web.dart][]
- Hierarchical logging is enabled

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

```dart
import 'package:hrk_logging/hrk_logging.dart';

void main() {
  configureHrkLogging();
  final log = Logger('HrkLogger')..level = Level.ALL;
  log.shout('sample shout');
  log.severe('sample severe');
  log.warning('sample warning');
  log.info('sample info');
  log.config('sample config');
  log.debug('sample debug');
  log.fine('sample fine');
  log.finer('sample finer');
  log.finest('sample finest');
}
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.

[lib/src/helper/helper_non_web.dart]: lib/src/helper/helper_non_web.dart
