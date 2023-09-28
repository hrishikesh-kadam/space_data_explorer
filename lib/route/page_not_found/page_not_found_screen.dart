import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

import '../../constants/dimensions.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/directionality_widget.dart';

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
    return getDirectionality(
      child: Scaffold(
        appBar: getAppBar(
          context: context,
          title: Text(title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.pagePadding),
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
      ),
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
