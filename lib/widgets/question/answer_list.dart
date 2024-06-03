import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/quiz_api.dart';

class AnswerList extends ConsumerWidget {
  final Question question;
  final quizApi = QuizApi();
  final resultProvider;

  AnswerList(this.question, this.resultProvider);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayOptions = List<Widget>.from(question.options.map(
      (option) => ListTile(
        title: Text(option),
        onTap: () => answerHandler(option, ref),
      ),
    ));

    return Expanded(child: ListView(children: displayOptions));
  }

  void answerHandler(String option, WidgetRef ref) async {
    quizApi
        .checkAnswer(question.topicId, question.id, option)
        .then((isCorrect) => update(ref, question, isCorrect));
  }

  void update(ref, value, isCorrect) async {
    ref.read(resultProvider.notifier).state = isCorrect;
    if (isCorrect) {
      final key = question.topicId.toString();
      final prefs = await SharedPreferences.getInstance();
      final answeredQuestions = prefs.getStringList(key) ?? [];
      if (!answeredQuestions.contains(value.id.toString())) {
        answeredQuestions.add(value.id.toString());
      }
      prefs.setStringList(key, answeredQuestions);
    }
  }
}
