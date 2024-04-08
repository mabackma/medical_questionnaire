import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:provider/provider.dart';

class SummaryDetailsPage extends StatelessWidget {
  final Map<String, dynamic> summary;

  // Required field summary is received from the ShowSummaries widget.
  SummaryDetailsPage({Key? key, required this.summary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputString = summary['inputString'] as String;
    final englishInputString = summary['englishInputString'] as String;
    final englishSummary = summary['englishSummary'] as String;
    final summaryText = summary['summary'] as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Input String: $inputString',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'English Input String: $englishInputString',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'John Snow Medical Summary: $englishSummary',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Summary: $summaryText',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
