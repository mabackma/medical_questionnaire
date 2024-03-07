import 'package:flutter/material.dart';

class UserAnswerWidget extends StatelessWidget {
  final String userAnswer;
  const UserAnswerWidget({super.key, required this.userAnswer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (userAnswer.isNotEmpty)
            const Text(
              'User answer:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          const SizedBox(height: 8.0),
          Text(
            userAnswer,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
