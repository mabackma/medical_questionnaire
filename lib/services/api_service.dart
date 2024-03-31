import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // Fetch all the questions from the server.
  static Future<List<Map<String, dynamic>>> getAll() async {
    try {
      final response =
          //await http.get(Uri.parse('http://localhost:5001/questionnaire'));
          await http.get(Uri.parse('http://127.0.0.1:5001/questionnaire'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert the JSON response into a list of maps
        return jsonResponse.map((json) {
          // Check if the 'choices' exists and is a list
          List<Map<String, dynamic>> choices =
              (json['choices'] != null && json['choices'] is List)
                  ? List<Map<String, dynamic>>.from(json['choices'])
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
  static Future<void> postAnswers(Map<String, dynamic> answers) async {
    try {
      final response = await http.post(
        //Uri.parse('http://localhost:5001/answers'),
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

  // Send questions and answers to the server to generate a summary.
  static Future<void> postAnswersForSummary(
      Map<String, dynamic> answers) async {
    try {
      final response = await http.post(
        //Uri.parse('http://localhost:5001/answers'),
        Uri.parse('http://localhost:5002/make_summary'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(answers),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to send answers: ${response.statusCode}');
      } else {
        print('Answers for summary sent successfully');
      }
    } catch (error) {
      throw Exception('Error sending answers for summary: $error');
    }
  }

  // Fetch the summaries from the server.
  static Future<List<Map<String, dynamic>>> getSummaries(user) async {
    try {
      final response = await http.post(
        //Uri.parse('http://localhost:5001/get_summary'),
        Uri.parse('http://localhost:5002/get_summary'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'user': user}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        List<dynamic> jsonSummaries = jsonResponse['summaries'];

        // Convert the JSON response into a list of maps
        List<Map<String, dynamic>> summaries = jsonSummaries.map((json) {
          return {
            "summary": json['summary'],
          };
        }).toList();

        print('Summaries fetched successfully');
        return summaries;
      } else {
        throw Exception('Failed to load summaries: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching summaries: $error');
    }
  }
}
