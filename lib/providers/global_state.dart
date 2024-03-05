import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  List<Map<String, dynamic>> questions = [];

  Future<void> getQuestions() async {
    // Simulating an asynchronous operation with a delay
    await Future.delayed(Duration(seconds: 1));

    questions = [
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
