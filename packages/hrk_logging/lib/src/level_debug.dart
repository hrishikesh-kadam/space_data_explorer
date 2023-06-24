import 'package:logging/logging.dart';

class HrkLevel extends Level {
  const HrkLevel(super.name, super.value);

  // ignore: constant_identifier_names
  static const Level DEBUG = Level('DEBUG', 600);

  // ignore: constant_identifier_names
  static const List<Level> LEVELS = [
    Level.ALL,
    Level.FINEST,
    Level.FINER,
    Level.FINE,
    HrkLevel.DEBUG,
    Level.CONFIG,
    Level.INFO,
    Level.WARNING,
    Level.SEVERE,
    Level.SHOUT,
    Level.OFF
  ];
}

extension HrkLogger on Logger {
  void debug(Object? message, [Object? error, StackTrace? stackTrace]) =>
      log(HrkLevel.DEBUG, message, error, stackTrace);
}
