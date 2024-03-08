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
                  onTap: () {
                    // Handle tap action here
                    print('User answer tapped: $userAnswer');
                  },
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
