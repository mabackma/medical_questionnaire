import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:provider/provider.dart';

// Displays a list of summaries of the questionnaire.
class ShowSummaries extends StatelessWidget {
  const ShowSummaries({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the list of summaries from the global state
    final summaries = context.watch<GlobalState>().summaries;

    return ListView.builder(
      itemCount: summaries.length,
      itemBuilder: (context, index) {
        final summary = summaries[index]['summary'] as String;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                summary,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}
