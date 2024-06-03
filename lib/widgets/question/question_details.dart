import 'package:dad_1/providers/providers.dart';
import 'package:dad_1/services/quiz_api.dart';
import 'package:dad_1/widgets/util/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionDetails extends ConsumerWidget {
  final Question question;

  QuestionDetails(this.question);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          'Question ${question.id}',
          leading: const Icon(Icons.question_answer),
        ),
        Text(question.question, style: const TextStyle(fontSize: 20)),
        question.imageUrl != ''
            ? Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Image.network(question.imageUrl),
              )
            : Container(),
      ],
    );
  }
}
