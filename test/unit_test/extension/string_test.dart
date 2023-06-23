import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/extensions/string.dart';

void main() {
  test('extension on String Unit Test', () async {
    expect('Lorem', 'LOREM'.capitalize());
    expect('Lorem', 'lorem'.capitalize());
    expect('L', 'l'.capitalize());
    expect('Lo', 'Lo'.capitalize());
    expect('Lorem', 'loRem'.capitalize());
    expect('', ''.capitalize());
  });
}
