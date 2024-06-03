import 'package:dad_1/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: routes,
);

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: MaterialApp.router(routerConfig: router));
  }
}
