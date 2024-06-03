import 'package:dad_1/widgets/util/section_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/screen_wrapper.dart';
import '../widgets/topic_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(Column(children: [
      const SectionHeader("Topics",
          subtitle: "Select a topic to start a quiz.",
          leading: Icon(Icons.book)),
      TopicList(),
      const Divider(),
      ListTile(
          title: const Text('Generic practice'),
          subtitle: const Text(
              'Practice questions from the topics that you have the least correct answers for.'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => context.go('/generic'))
    ]));
  }
}
