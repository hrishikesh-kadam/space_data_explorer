import 'package:recase/recase.dart';

class Constants {
  static const String appName = 'space_data_explorer';
  static const String version = '0.6.0';
  static const authorUsername = 'hrishikesh-kadam';
  static final Uri linktreeUri = Uri.https(
    'linktr.ee',
    authorUsername.snakeCase,
  );
  static final Uri sourceRepoUri = Uri.https(
    'github.com',
    '$authorUsername/$appName',
  );
}
