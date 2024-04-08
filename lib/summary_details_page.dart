import 'package:flutter/material.dart';

class SummaryDetailsPage extends StatelessWidget {
  final Map<String, dynamic> summary;

  // Required field summary is received from the ShowSummaries widget.
  const SummaryDetailsPage({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    // Get the fields from the summary map
    final Map<String, dynamic> summary =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
        child: Center(
          child: Column(
            children: [
              Text(
                'Input String: $inputString',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Icon(
                Icons.arrow_circle_down_outlined,
                color: Colors.white,
                size: 40,
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
              const Icon(
                Icons.arrow_circle_down_outlined,
                color: Colors.white,
                size: 40,
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
              const Icon(
                Icons.arrow_circle_down_outlined,
                color: Colors.white,
                size: 40,
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
      ),
    );
  }
}
