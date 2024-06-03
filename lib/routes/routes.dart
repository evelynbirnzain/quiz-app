import 'package:dad_1/screens/question_screen.dart';
import 'package:dad_1/screens/statistics_screen.dart';

import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';

final routes = [
  GoRoute(path: '/', builder: (context, state) => HomeScreen()),
  GoRoute(
      path: '/topics/:id',
      builder: (context, state) =>
          QuestionScreen(int.parse(state.pathParameters['id']!))),
  GoRoute(path: '/statistics', builder: (context, state) => StatisticsScreen()),
  GoRoute(path: '/generic', builder: (context, state) => QuestionScreen(-1)),
];
