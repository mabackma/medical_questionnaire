import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:provider/provider.dart';
import 'Questionnaire.dart';

// The Questions widget displays a list of questions and their multiple choice answers.
class ShowQuestions extends StatelessWidget {
  const ShowQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    // Lists all the questions in the global state.
    final questionnaire = context.watch<GlobalState>().questionnaire.map(
      (q) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          color: Colors.blue[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Questionnaire(
                question_id: q["question_id"] as String,
                question: q["question"] as String,
                choices: q["choices"] as List<String>,
              ) as Widget,
            ],
          ),
        );
      },
    ).toList();

    return questionnaire.isEmpty
        ? const CircularProgressIndicator()
        : ListView(
            padding: const EdgeInsets.all(18),
            children: questionnaire,
          );
  }
}
