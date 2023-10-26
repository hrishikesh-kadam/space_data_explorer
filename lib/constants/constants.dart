import 'package:recase/recase.dart';

class Constants {
  static const String appName = 'space_data_explorer';
  static const String version = '0.8.0';
  static const authorUsername = 'hrishikesh-kadam';
  static final Uri linktreeUrl = Uri.https(
    'linktr.ee',
    authorUsername.snakeCase,
  );
  static final Uri sourceRepoUrl = Uri.https(
    'github.com',
    '$authorUsername/$appName',
  );
}
