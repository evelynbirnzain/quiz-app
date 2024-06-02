import 'dart:convert';

import 'package:dad_1/screens/statistics_screen.dart';
import 'package:dad_1/services/quiz_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_data/test_data.dart';

void main() {
  setUp(() {
    nock.init();
    nock(url).get('/topics').reply(200, testTopics);
    nock(url).get('/topics').reply(200, testTopics);
  });

  tearDown(() {
    nock.cleanAll();
  });

  testWidgets("Statistics page shows correct total answer count",
      (tester) async {
    SharedPreferences.setMockInitialValues({
      "2": ["1", "2", "3"],
      "3": ["2"]
    });

    await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: StatisticsScreen())));
    await tester.pumpAndSettle();

    final totalFinder =
        find.text("You have answered 4 question(s) correctly in total.");
    expect(totalFinder, findsOneWidget);
  });

  testWidgets("Statistics page shows topic specific statistics for a topic",
      (tester) async {
    SharedPreferences.setMockInitialValues({
      "1": ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
      "3": ["2"]
    });

    await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: StatisticsScreen())));
    await tester.pumpAndSettle();

    final tableFinder = find.byType(DataTable);
    expect(tableFinder, findsOneWidget);

    final textFinder = find.text(testTopics[0]['name']!.toString());
    expect(textFinder, findsOneWidget);

    final textFinder2 = find.text("9");
    expect(textFinder2, findsOneWidget);
  });
}
