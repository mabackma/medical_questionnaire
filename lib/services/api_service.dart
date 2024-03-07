import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // Fetch all the questions from the server.
  static Future<List<Map<String, dynamic>>> getAll() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:5001/questionnaire'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert the JSON response into a list of maps
        return jsonResponse.map((json) {
          // Check if the 'choices' exists and is a list
          List<String> choices =
              (json['choices'] != null && json['choices'] is List)
                  ? List<String>.from(json['choices'])
                  : [];

          return {
            "question_id": json['_id'],
            "question": json['question'],
            "choices": choices,
          };
        }).toList();
      } else {
        // If the request fails, log the error
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions that occur during the HTTP request
      throw Exception('Error fetching questions: $error');
    }
  }

  // Send all the answers to the server.
  static Future<void> postAnswers(List<Map<String, dynamic>> answers) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5001/answers'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(answers),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to send answers: ${response.statusCode}');
      } else {
        print('Answers sent successfully');
      }
    } catch (error) {
      throw Exception('Error sending answers: $error');
    }
  }
}
