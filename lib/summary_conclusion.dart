import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:medical_questionnaire/show_summaries.dart';
import 'package:provider/provider.dart';

class SummaryConclusion extends StatefulWidget {
  const SummaryConclusion({super.key, required this.title});

  final String title;

  @override
  _SummaryConclusionState createState() => _SummaryConclusionState();
}

class _SummaryConclusionState extends State<SummaryConclusion> {
  @override
  void initState() {
    super.initState();
    handleSummaries();
  }

  void handleSummaries() async {
    await context.read<GlobalState>().getSummaryFromSummaries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yhteenveto kaikista tiiivistelmistä"),
      ),
      body: Column(
        children: [
          Consumer<GlobalState>(
            builder: (context, globalState, _) {
              // Get the summary conclusion from the global state
              String summaryConclusion = globalState.summaryConclusion;

              return Expanded(
                child: Text(
                  summaryConclusion,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
