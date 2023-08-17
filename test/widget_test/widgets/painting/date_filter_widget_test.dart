import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/widgets/date_filter_widget.dart';
import '../../../src/nasa/cad/query/date_filter_widget.dart';

void main() {
  group('$DateFilterWidget Painting Test', () {
    testWidgets('startEndAlign', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DateFilterWidget(
          title: title,
          startTitle: startTitle,
          endTitle: endTitle,
          dateRange: dateRange,
          firstDate: firstDate,
          lastDate: lastDate,
          dateFormat: dateFormat,
          selectButtonTitle: selectButtonTitle,
          onDateRangeSelected: (_) {},
          startEndAlign: true,
        ),
      ));
      expect(tester.getSize(startLabelFinder), tester.getSize(startDateFinder));
      expect(tester.getSize(startLabelFinder), tester.getSize(endLabelFinder));
      expect(tester.getSize(startLabelFinder), tester.getSize(endDateFinder));
    });
  });
}
