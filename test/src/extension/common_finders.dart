import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';

// LABEL: eligible-hrk_flutter_test_batteries
extension HrkFinders on CommonFinders {
  Finder byKeyStartsWith(
    String keyPrefix, {
    String? description,
    bool skipOffstage = true,
  }) {
    return find.byWidgetPredicate(
      (widget) {
        if (widget.key is ValueKey<String>) {
          final key = widget.key as ValueKey<String>;
          if (key.value.startsWith(keyPrefix)) {
            return true;
          }
        }
        return false;
      },
      description: description,
      skipOffstage: skipOffstage,
    );
  }

  Finder descendantText({
    required Finder of,
    required String text,
    bool matchRoot = false,
    bool findRichText = false,
    bool skipOffstage = true,
  }) {
    return find.descendant(
      of: of,
      matching: find.text(
        text,
        findRichText: findRichText,
        skipOffstage: skipOffstage,
      ),
      matchRoot: matchRoot,
      skipOffstage: skipOffstage,
    );
  }

  Finder descendantTextContaining({
    required Finder of,
    required Pattern pattern,
    bool matchRoot = false,
    bool findRichText = false,
    bool skipOffstage = true,
  }) {
    return find.descendant(
      of: of,
      matching: find.textContaining(
        pattern,
        findRichText: findRichText,
        skipOffstage: skipOffstage,
      ),
      matchRoot: matchRoot,
      skipOffstage: skipOffstage,
    );
  }
}
