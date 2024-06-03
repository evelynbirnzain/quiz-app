import 'package:dad_1/widgets/stats/overview_stats.dart';
import 'package:dad_1/widgets/screen_wrapper.dart';
import 'package:dad_1/widgets/stats/statistics_per_topic.dart';
import 'package:dad_1/widgets/util/section_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/quiz_api.dart';

class StatisticsScreen extends ConsumerWidget {
  final quizApi = QuizApi();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenWrapper(
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SectionHeader('Statistics',
            leading: Icon(Icons.bar_chart),
            subtitle: 'See how many questions you have answered correctly.'),
        OverviewStatistics(),
        const Divider(),
        const SectionHeader('Statistics per topic',
            leading: Icon(Icons.topic),
            subtitle:
                'See how many questions you have answered correctly for each topic.'),
        StatisticsPerTopic()
      ]),
    );
  }
}
