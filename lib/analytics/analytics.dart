import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsContentType {
  static const String externalUrl = 'external_url';
}

class Analytics {
  static Future<void> logSelectExternalUrl({
    required Uri uri,
  }) async {
    FirebaseAnalytics.instance.logSelectContent(
      contentType: AnalyticsContentType.externalUrl,
      itemId: uri.toString(),
    );
  }
}
