import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class ResultWidget extends ConsumerWidget {
  final int topicId;
  final StateProvider<bool?> resultProvider;

  const ResultWidget(this.topicId, this.resultProvider);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(resultProvider);

    if (result == null) {
      return Container();
    } else if (result) {
      return Container(
        color: Colors.green,
        child: ListTile(
          textColor: Colors.white,
          leading: const Icon(Icons.check, color: Colors.white),
          trailing: ElevatedButton(
              onPressed: () => nextQuestion(ref), child: const Text('Next')),
          title: const Text('Correct'),
        ),
      );
    } else {
      return Container(
        color: Colors.red,
        child: const ListTile(
          textColor: Colors.white,
          leading: Icon(Icons.close, color: Colors.white),
          title: Text('Incorrect'),
        ),
      );
    }
  }

  void nextQuestion(WidgetRef ref) {
    ref.refresh(questionProvider(topicId));
    ref.read(resultProvider.notifier).state = null;
  }
}
