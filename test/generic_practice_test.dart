import 'dart:convert';

import 'package:dad_1/quiz_app.dart';
import 'package:dad_1/services/quiz_api.dart';
import 'package:dad_1/widgets/topic_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_data/test_data.dart';


void main() {
  setUp(() {
    nock.init();
    nock(url).get('/topics').reply(200, testTopics);
    nock(url).get('/topics').reply(200, testTopics);

    nock(url).get('/topics/1/questions').reply(200, testQuestion);
  });

  tearDown(() {
    nock.cleanAll();
  });

  testWidgets(
      "Generic practice shows questions from a topic with the fewest correct answers",
          (tester) async {
        SharedPreferences.setMockInitialValues({
          "2": ["7", "8"],
          "3": ["10", "12", "13"],
          "4": ["11", "33", "22"],
        });

        await tester.pumpWidget(QuizApp());
        await tester.pumpAndSettle();

        final topicsFinder = find.byType(TopicList);
        expect(topicsFinder, findsOneWidget);

        final listTileFinder = find.byType(ListTile);
        expect(listTileFinder, findsNWidgets(testTopics.length + 1));

        final tileFinder = find.widgetWithText(ListTile, "Generic practice");
        expect(tileFinder, findsOneWidget);

        await tester.tap(tileFinder);
        await tester.pumpAndSettle();

        final question = Question.fromJson(testQuestion);
        final questionFinder = find.text(question.question);
        expect(questionFinder, findsOneWidget);

        final optionsFinder = find.byType(ListTile);
        expect(optionsFinder, findsNWidgets(question.options.length));

        for (var i = 0; i < question.options.length; i++) {
          final option = question.options[i];
          final optionFinder = find.widgetWithText(ListTile, option);
          expect(optionFinder, findsOneWidget);
        }
      });
}