import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  List<String> questions = [];

  Future<void> getQuestions() async {
    await Future.delayed(const Duration(seconds: 1));

    questions = ["eka itemi", "toka itemi"];

    notifyListeners();
  }
}
