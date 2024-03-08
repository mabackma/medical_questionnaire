import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:medical_questionnaire/recording_widget.dart';
import 'package:provider/provider.dart';

// Class for the multiple choice questions.
class Question extends StatefulWidget {
  final String questionId;
  final String question;
  final List<String> choices;

  // Constructor with named parameters
  const Question({
    required this.questionId,
    required this.question,
    required this.choices,
    super.key,
  });

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  String? selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.question,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 3,
          ),
        ),
        Column(
          children: widget.choices.isNotEmpty
              ? widget.choices.map((choice) {
                  return InkWell(
                    child: Container(
                      height: 30,
                      margin: const EdgeInsets.only(bottom: 20),
                      color: choice == selectedChoice
                          ? Colors.deepPurple[
                              400] // Change color for selected choice
                          : Colors.deepPurple[200],
                      child: Padding(
                        // Wrap Text widget with Padding
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          choice,
                          textAlign: TextAlign.center, // Center align the text
                        ),
                      ),
                    ),
                    onTap: () => handleTap(choice, context),
                  );
                }).toList()
              // If there are no choices, display the recording widget
              : [
                  Column(
                    children: [
                      Container(
                        height: 70,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: const Text(
                          "record your answer:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 3,
                          ),
                        ),
                      ),
                      const RecordingWidget(),
                    ],
                  ),
                ],
        ),
      ],
    );
  }

  // Method to save the question and the selected choice.
  void handleTap(String choice, BuildContext context) {
    setState(() {
      selectedChoice = choice; // Update selected choice
    });

    final answer = {
      'question_id': widget.questionId,
      'question': widget.question,
      'choice': choice,
    };

    final globalState = Provider.of<GlobalState>(context, listen: false);
    // Remove any existing answer for the same question
    globalState.answers
        .removeWhere((ans) => ans['question_id'] == widget.questionId);
    // Add the new answer
    globalState.answers.add(answer);
  }

  @override
  void initState() {
    super.initState();
    // Retrieve the selected choice from the global state when the widget initializes
    final globalState = Provider.of<GlobalState>(context, listen: false);
    final savedAnswer = globalState.answers.firstWhere(
      (ans) => ans['question_id'] == widget.questionId,
      orElse: () => {}, // Return an empty Map if no saved answer is found
    );
    if (savedAnswer != null) {
      selectedChoice = savedAnswer['choice'];
    }
  }
}
