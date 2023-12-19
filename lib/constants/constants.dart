import 'package:recase/recase.dart';

class Constants {
  static const String appName = 'space_data_explorer';
  static const String version = '1.0.0';
  static const String authorUsername = 'hrishikesh-kadam';
  static const String androidAppId = 'dev.hrishikesh_kadam.flutter.$appName';
  static final Uri linktreeUrl = Uri.https(
    'linktr.ee',
    authorUsername.snakeCase,
  );
  static final Uri sourceRepoUrl = Uri.https(
    'github.com',
    '$authorUsername/$appName',
  );
  // static final Uri googlePlayStoreBadgeUrl = Uri.https(
  //   'play.google.com',
  //   'intl/en_us/badges/static/images/badges/en_badge_web_generic.png',
  // );
  static final Uri googlePlayStoreUrl = Uri.https(
    'play.google.com',
    'store/apps/details',
    {'id': androidAppId},
  );
  static final Uri appleAppStoreUrl = Uri.https(
    'apps.apple.com',
    'us/app/space-data-explorer/id6471949704',
  );
}
