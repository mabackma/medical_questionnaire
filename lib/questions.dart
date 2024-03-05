import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:provider/provider.dart';

class Questions extends StatelessWidget {
  const Questions({required Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lists all the questions in the global state.
    final questions = context.watch<GlobalState>().questions.map(
      (q) {
        return InkWell(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            color: Colors.blue[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(q["question"]),
                Choices(q["choices"] as List<String>),
              ],
            ),
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

class Choices extends StatelessWidget {
  const Choices(this.choices, {Key? key}) : super(key: key);

  final List<String> choices;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: choices.map((choice) {
        return InkWell(
          child: Container(
            height: 30,
            margin: const EdgeInsets.only(top: 10),
            color: Colors.purple[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(choice),
              ],
            ),
          ),
          onTap: () => print("Tapped $choice"),
        );
      }).toList(),
    );
  }
}
