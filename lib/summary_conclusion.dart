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

  void moveToSummaries() {
    context.read<GlobalState>().answers.clear();
    context.read<GlobalState>().summaryConclusion = '';
    Navigator.pushReplacementNamed(context, '/summary');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Consumer<GlobalState>(
            builder: (context, globalState, _) {
              return globalState.summaryConclusion.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              globalState.summaryConclusion,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}
