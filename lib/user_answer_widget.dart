import 'package:flutter/material.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (userAnswer.isEmpty)
              ? const Text(
                  'Vastauksesi tekstimuodossa tulee tähän',
                  style: TextStyle(fontSize: 16.0),
                )
              : Text(
                  userAnswer,
                  style: const TextStyle(fontSize: 16.0),
                ),
        ],
      ),
    );
  }
}
