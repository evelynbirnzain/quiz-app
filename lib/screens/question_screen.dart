import 'package:dad_1/widgets/question/answer_list.dart';
import 'package:dad_1/widgets/question/question_details.dart';
import 'package:dad_1/widgets/question/result_widget.dart';
import 'package:dad_1/widgets/util/section_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../widgets/screen_wrapper.dart';

class QuestionScreen extends ConsumerWidget {
  final int topicId;

  final StateProvider<bool?> resultProvider = StateProvider((ref) => null);

  QuestionScreen(this.topicId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionFuture = ref.watch(questionProvider(topicId));

    return ScreenWrapper(
      questionFuture.when(
        data: (question) => Column(children: [
          QuestionDetails(question),
          const SectionHeader('Answer options',
              leading: Icon(Icons.list),
              subtitle: 'Select the correct answer.'),
          AnswerList(question, resultProvider),
          ResultWidget(topicId, resultProvider)
        ]),
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text(error.toString()),
      ),
    );
  }
}
