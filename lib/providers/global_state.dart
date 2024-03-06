import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../questionnaire.dart';

class GlobalState extends ChangeNotifier {
  List<Map<String, dynamic>> questionnaire = [];

  Future<void> getQuestions() async {
/*
    try {
      final response =
          await http.get(Uri.parse('http://localhost:5001/get_from_database'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        questions = jsonResponse.cast<Map<String, dynamic>>();
        print('Fetched questions: $questions');
      } else {
        // If the request fails, log the error
        print('Failed to load questions: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions that occur during the HTTP request
      print('Error fetching questions: $error');
    }
*/
    questionnaire = [
      {
        "question": "first question",
        "choices": ["a", "b", "c"]
      },
      {
        "question": "second question",
        "choices": ["1", "2", "3"]
      },
      {
        "question": "third question",
        "choices": ["first choice", "second choice", "third choice"]
      },
    ];

    // This will trigger a rebuild of the widget.
    notifyListeners();
  }
}
