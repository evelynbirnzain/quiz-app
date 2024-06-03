import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/quiz_api.dart';
import '../services/statistics_service.dart';

final questionProvider =
    FutureProvider.autoDispose.family<Question, int>((ref, topicId) async {
  final quizApi = QuizApi();
  if (topicId == -1) {
    final statisticsService = StatisticsService();
    final answeredQuestionsPerTopic =
        await statisticsService.getAnsweredQuestionsPerTopic();
    final leastAnsweredTopics = answeredQuestionsPerTopic
        .where((element) =>
            element.answeredQuestions ==
            answeredQuestionsPerTopic.last.answeredQuestions)
        .toList();
    final random = Random();
    final randomTopic =
        leastAnsweredTopics[random.nextInt(leastAnsweredTopics.length)];
    topicId = randomTopic.topicId;
  }
  final question = await quizApi.getQuestionForTopic(topicId);
  return question;
});

