import 'package:dad_1/services/statistics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OverviewStatistics extends ConsumerWidget {
  final statsService = StatisticsService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: statsService.getTotalAnsweredQuestions(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final stats = snapshot.data!;
          return Column(
            children: [
              Text('You have answered $stats question(s) correctly in total.',
                  style: const TextStyle(fontSize: 16)),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
