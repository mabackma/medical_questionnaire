import 'package:flutter/material.dart';
import 'package:medical_questionnaire/SummaryDetailsPage.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:provider/provider.dart';

// Displays a list of summaries of the questionnaire.
class ShowSummaries extends StatelessWidget {
  const ShowSummaries({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, globalState, child) {
        // Get the list of summaries from the global state
        final summaries = globalState.summaries;

        if (summaries.isEmpty) {
          // Show a spinner if summaries are empty
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        return ListView.builder(
          itemCount: summaries.length,
          itemBuilder: (context, index) {
            final summary = summaries[index];
            final summaryText = summary['summary'] as String;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      summaryText,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    print('Tapped on summary: $summary');
                    // Navigate to summary details page and pass additional fields
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SummaryDetailsPage(summary: summary),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
