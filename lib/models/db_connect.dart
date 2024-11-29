import 'package:http/http.dart' as http;
import './question_model.dart';
import 'dart:convert';

class DBconnect {
  // function for add question to database
  // declare name of the table after DB link as json
  final url = Uri.parse(
      'https://quizzy-duel-default-rtdb.asia-southeast1.firebasedatabase.app/question.json');

  // fetching data from DB
  Future<List<Question>> fetchQuestions() async {
    return http.get(url).then((response) {
      // the 'then' method returns a 'response' which is our data
      // to whats inside we have to decode it first
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];

      data.forEach((key, value) {
        var newQuestion = Question(
          id: key,
          title: value['title'],
          options: Map.castFrom(value['options']),
        );

        // add new questions
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });
  }
}
