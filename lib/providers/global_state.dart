import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GlobalState extends ChangeNotifier {
  List<Map<String, dynamic>> questionnaire = [];

  // Method to fetch the entire questionnaire from the server
  Future<void> getQuestionnaire() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:5001/get_from_database'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert the JSON response into a list of Questionnaire objects
        questionnaire = jsonResponse.map((json) {
          return {
            "question": json['question'],
            "choices": List<String>.from(json['choices']),
          };
        }).toList();

        print('Fetched questions: $questionnaire');
      } else {
        // If the request fails, log the error
        print('Failed to load questions: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions that occur during the HTTP request
      print('Error fetching questions: $error');
    }

    // This will trigger a rebuild of the widget.
    notifyListeners();
  }
}
