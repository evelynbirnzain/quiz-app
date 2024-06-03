import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/quiz_api.dart';

class TopicList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizApi = QuizApi();

    return FutureBuilder(
      future: quizApi.getTopics(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final topics = snapshot.data!;
          if (topics.isEmpty) {
            return const Text('No topics available.');
          }
          final widgets = List<Widget>.from(snapshot.data!.map(
            (topic) => ListTile(
              title: Text(topic.name),
              onTap: () => context.go('/topics/${topic.id}'),
            ),
          ));
          return Expanded(
              child: ListView(
            children: widgets,
          ));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
