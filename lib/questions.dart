import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:provider/provider.dart';
import 'Choices.dart';

// The Questions widget displays a list of questions and their multiple choice answers.
class Questions extends StatelessWidget {
  const Questions({required Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lists all the questions in the global state.
    final questions = context.watch<GlobalState>().questions.map(
      (q) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          color: Colors.blue[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(q["question"]),
              Choices(
                question: q["question"] as String,
                choices: q["choices"] as List<String>,
              ) as Widget,
            ],
          ),
        );
      },
    ).toList();

    return questions.isEmpty
        ? const CircularProgressIndicator()
        : ListView(
            padding: const EdgeInsets.all(18),
            children: questions,
          );
  }
}
