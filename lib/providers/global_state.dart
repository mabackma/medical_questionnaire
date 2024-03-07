import 'package:flutter/material.dart';
import 'package:medical_questionnaire/services/api_service.dart';

class GlobalState extends ChangeNotifier {
  List<Map<String, dynamic>> questionnaire = [];

  // Method to fetch the entire questionnaire from the server
  Future<void> getQuestionnaire() async {
    try {
      questionnaire = await ApiService.getAll();
      print('Fetched questions: $questionnaire');
    } catch (error) {
      print('Error fetching questions: $error');
    }

    // This will trigger a rebuild of the widget.
    notifyListeners();
  }
}
