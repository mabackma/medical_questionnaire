import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // Method to fetch the entire questionnaire from the server
  static Future<List<Map<String, dynamic>>> getAll() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:5001/questionnaire'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert the JSON response into a list of Questionnaire objects
        return jsonResponse.map((json) {
          return {
            "question": json['question'],
            "choices": List<String>.from(json['choices']),
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
}
