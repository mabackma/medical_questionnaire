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
    final theme = Theme.of(context);

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
                    onTap: () => handleTapChoice(choice, context),
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: choice == selectedChoice
                              ? Colors.white // Border color for selected choice
                              : Colors
                                  .transparent, // No border for unselected choices
                          width: 5, // Border width
                        ),
                        color: choice == selectedChoice
                            ? theme.colorScheme
                                .primary // Change color for selected choice
                            : const Color.fromARGB(255, 26, 94, 129),
                        borderRadius: BorderRadius.circular(5), // Border radius
                      ),
                      child: Padding(
                        // Wrap Text widget with Padding
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          choice,
                          textAlign: TextAlign.center, // Center align the text
                          style: const TextStyle(
                            color: Colors.white, fontSize: 16, // Text color
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList()
              // If there are no choices, display the recording widget
              : [
                  Column(
                    children: [
                      Container(
                        child: const Text(
                          "Äänitä vastauksesi painamalla mikrofoninappia:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 3,
                          ),
                        ),
                      ),
                      RecordingWidget(
                        questionId: widget.questionId,
                        question: widget.question,
                      ),
                    ],
                  ),
                ],
        ),
      ],
    );
  }

  // Method to save the question id and the selected choice.
  void handleTapChoice(String choice, BuildContext context) {
    setState(() {
      selectedChoice = choice; // Update selected choice
    });

    final answer = {
      'question_id': widget.questionId,
      'question': widget.question,
      'user_answer': choice,
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
    if (savedAnswer.isNotEmpty) {
      selectedChoice = savedAnswer['user_answer'];
    }
  }
}
