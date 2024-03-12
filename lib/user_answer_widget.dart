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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vastauksesi:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          (userAnswer.isEmpty)
              ? const Text(
                  'Vastauksesi tulee tähän tekstimuodossa hetken kuluttua.',
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
