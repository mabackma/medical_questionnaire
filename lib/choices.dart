import 'package:flutter/material.dart';

// Class for the multiple choice selection for the question.
class Choices extends StatelessWidget {
  final String question;
  final List<String> choices;

  // Constructor with named parameters
  const Choices({
    required this.question,
    required this.choices,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: choices.map((choice) {
        return InkWell(
          child: Container(
            height: 30,
            margin: const EdgeInsets.only(top: 10),
            color: Colors.deepPurple[200],
            child: Padding(
              // Wrap Text widget with Padding
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                choice,
                textAlign: TextAlign.center, // Center align the text
              ),
            ),
          ),
          onTap: () => handleTap(question, choice),
        );
      }).toList(),
    );
  }

  // Method to save the question and the selected choice.
  void handleTap(question, choice) {
    print("Tapped on $choice for question $question");
  }
}
