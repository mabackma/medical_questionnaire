import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:provider/provider.dart';

// Class for the multiple choice questions.
class Questionnaire extends StatelessWidget {
  final String question_id;
  final String question;
  final List<String> choices;

  // Constructor with named parameters
  const Questionnaire({
    required this.question_id,
    required this.question,
    required this.choices,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 3,
          ),
        ),
        Column(
          children: choices.map((choice) {
            return InkWell(
              child: Container(
                height: 30,
                margin: const EdgeInsets.only(bottom: 20),
                color: Colors.deepPurple[200],
                child: Padding(
                  // Wrap Text widget with Padding
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    choice,
                    textAlign: TextAlign.center, // Center align the text
                  ),
                ),
              ),
              onTap: () => handleTap(question, choice, context),
            );
          }).toList(),
        )
      ],
    );
  }

  // Method to save the question and the selected choice.
  void handleTap(String question, String choice, BuildContext context) {
    print("Tapped on choice $choice for question $question_id $question");
    final answer = {
      'question_id': question_id,
      'question': question,
      'choice': choice,
    };

    final globalState = Provider.of<GlobalState>(context, listen: false);
    globalState.answers.add(answer);
  }
}