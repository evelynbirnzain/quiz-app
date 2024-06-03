import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'https://dad-quiz-api.deno.dev';

class Topic {
  final int id;
  final String name;
  final String questionPath;

  Topic.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData['id'],
        name = jsonData['name'],
        questionPath = jsonData['question_path'];
}

class Question {
  final int id;
  final String imageUrl;
  final String question;
  final List<String> options;
  final String answerPostPath;
  final int topicId;

  Question.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData['id'],
        question = jsonData['question'],
        options = List<String>.from(jsonData['options']),
        answerPostPath = jsonData['answer_post_path'],
        imageUrl = jsonData['image_url'] ?? '',
        topicId = jsonData['topic_id'];
}

class QuizApi {
  Future<List<Topic>> getTopics() async {
    final response = await http.get(Uri.parse('$url/topics'));

    List<dynamic> topics = jsonDecode(response.body);
    return List<Topic>.from(topics.map(
      (jsonData) => Topic.fromJson(jsonData),
    ));
  }

  Future<Question> getQuestionForTopic(int topicId) async {
    final response = await http.get(
      Uri.parse('$url/topics/$topicId/questions'),
    );

    final json = jsonDecode(response.body);
    json['topic_id'] = topicId;

    return Question.fromJson(json);
  }

  Future<bool> checkAnswer(int topicId, int questionId, String option) async {
    final response = await http.post(
      Uri.parse(
          '$url/topics/$topicId/questions/$questionId/answers'),
      body: jsonEncode(<String, String>{
        'answer': option,
      }),
    );

    return jsonDecode(response.body)!['correct'];
  }
}
