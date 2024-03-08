import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:provider/provider.dart';

class UserAnswerWidget extends StatelessWidget {
  final String questionId;
  final String userAnswer;
  const UserAnswerWidget(
      {super.key, required this.questionId, required this.userAnswer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User answer:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          (userAnswer.isEmpty)
              ? const Text(
                  'The user answer will appear here.',
                  style: TextStyle(fontSize: 16.0),
                )
              : GestureDetector(
                  onTap: () => handleTapAnswer(questionId, userAnswer, context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userAnswer,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

// Method to save the question id and the user answer.
void handleTapAnswer(
    String questionId, String userAnswer, BuildContext context) {
  final answer = {
    'question_id': questionId,
    'user_answer': userAnswer,
  };

  final globalState = Provider.of<GlobalState>(context, listen: false);
  // Remove any existing answer for the same question
  globalState.answers.removeWhere((ans) => ans['question_id'] == questionId);
  // Add the new answer
  globalState.answers.add(answer);
}
