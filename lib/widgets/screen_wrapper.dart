import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget widget;

  const ScreenWrapper(this.widget);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
        actions: [
          IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () => context.go('/statistics'),
            icon: const Icon(Icons.bar_chart),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: widget,
      ),
    );
  }
}
