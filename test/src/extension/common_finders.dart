import 'package:flutter_test/flutter_test.dart';

// LABEL: eligible-hrk_flutter_test_batteries
extension HrkFinder on CommonFinders {
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
