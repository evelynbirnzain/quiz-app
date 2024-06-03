import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/statistics_service.dart';

class StatisticsPerTopic extends ConsumerWidget {
  final statisticsService = StatisticsService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: statisticsService.getAnsweredQuestionsPerTopic(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final entries = snapshot.data!;
          return DataTable(
            columns: const [
              DataColumn(
                  label: Text('Topic',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Correct answers',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: List<DataRow>.from(entries.map((entry) => DataRow(
                  cells: [
                    DataCell(Text(entry.topicName)),
                    DataCell(Text(entry.answeredQuestions.toString())),
                  ],
                ))),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
