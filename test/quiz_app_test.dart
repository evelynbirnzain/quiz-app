import 'dart:convert';

import 'package:dad_1/quiz_app.dart';
import 'package:dad_1/screens/question_screen.dart';
import 'package:dad_1/services/quiz_api.dart';
import 'package:dad_1/widgets/topic_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nock/nock.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_data/test_data.dart';

void main() {
  setUp(() {
    nock.init();
    nock(url).get('/topics').reply(200, testTopics);
    nock(url).get('/topics/1/questions').reply(200, testQuestion);
    nock(url)
        .post('/topics/1/questions/1/answers', jsonEncode({'answer': "1"}))
        .reply(200, {'correct': true});
  });

  tearDown(() {
    nock.cleanAll();
  });

  testWidgets("QuizApp shows list of topics at start", (tester) async {
    await tester.pumpWidget(QuizApp());
    await tester.pumpAndSettle();

    final topicsFinder = find.byType(TopicList);
    expect(topicsFinder, findsOneWidget);

    final listTileFinder = find.byType(ListTile);
    expect(listTileFinder, findsNWidgets(testTopics.length + 1));

    for (var i = 0; i < testTopics.length; i++) {
      final topic = Topic.fromJson(testTopics[i]);
      final tileFinder = find.widgetWithText(ListTile, topic.name);
      expect(tileFinder, findsOneWidget);
    }
  });

  testWidgets(
      "Selecting topic without images shows question from that topic and answer options",
      (tester) async {
    await tester.pumpWidget(QuizApp());
    await tester.pumpAndSettle();

    final tileFinder =
        find.widgetWithText(ListTile, testTopics[0]['name']!.toString());
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

  testWidgets("Selecting an answer option shows feedback matching API response",
      (tester) async {
    await tester
        .pumpWidget(ProviderScope(child: MaterialApp(home: QuestionScreen(1))));
    await tester.pumpAndSettle();

    final question = Question.fromJson(testQuestion);
    final option = question.options[0];
    final optionFinder = find.widgetWithText(ListTile, option);
    expect(optionFinder, findsOneWidget);

    await tester.tap(optionFinder);
    await tester.pumpAndSettle();

    final feedbackFinder = find.text('Correct');
    expect(feedbackFinder, findsOneWidget);
  });
}
