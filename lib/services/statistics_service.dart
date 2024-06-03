import 'package:dad_1/services/quiz_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Entry {
  final int topicId;
  final String topicName;
  final int answeredQuestions;

  Entry(this.topicId, this.topicName, this.answeredQuestions);
}

class StatisticsService {
  final sharedPreferences = SharedPreferences.getInstance();
  final quizApi = QuizApi();

  Future<int> getAnsweredQuestionsForTopic(int topicId) async {
    final prefs = await sharedPreferences;
    final answeredQuestions = prefs.getStringList(topicId.toString()) ?? [];
    return answeredQuestions.length;
  }

  Future<List<Entry>> getAnsweredQuestionsPerTopic() async {
    final prefs = await sharedPreferences;
    final topics = await quizApi.getTopics();
    final entries = <Entry>[];
    for (var topic in topics) {
      final answeredQuestions = prefs.getStringList(topic.id.toString()) ?? [];
      entries.add(Entry(topic.id, topic.name, answeredQuestions.length));
    }
    entries.sort((a, b) => b.answeredQuestions.compareTo(a.answeredQuestions));
    return entries;
  }

  Future<int> getTotalAnsweredQuestions() async {
    final prefs = await sharedPreferences;
    final topics = await quizApi.getTopics();
    int totalAnsweredQuestions = 0;
    for (var topic in topics) {
      final answeredQuestions = prefs.getStringList(topic.id.toString()) ?? [];
      totalAnsweredQuestions += answeredQuestions.length;
    }
    return totalAnsweredQuestions;
  }
}
