import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:hrk_flutter_batteries/hrk_flutter_batteries.dart';

import '../../widgets/app_bar.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({
    super.key,
    required this.title,
    this.extra,
    required this.l10n,
  });

  final String title;
  final JsonMap? extra;
  final AppLocalizations l10n;
  static const String keyPrefix = 'page_not_found_screen_';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: Tooltip(
          message: title,
          child: Text(title),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(HrkDimensions.pageMargin),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _getBodyTextMessage(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }

  String _getBodyTextMessage() {
    String message = '';
    if (extra != null && extra!.containsKey('$GoRouterState')) {
      final GoRouterState goRouterState = extra!['$GoRouterState'];
      message += '\'${goRouterState.uri}\'\n\n';
    }
    message += l10n.requestedPageNotFound;
    return message;
  }
}
