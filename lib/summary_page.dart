import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:medical_questionnaire/show_summaries.dart';
import 'package:provider/provider.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key, required this.title});

  final String title;

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  void initState() {
    super.initState();
    handleAnswers();
  }

  void handleAnswers() async {
    if (context.read<GlobalState>().answers.isNotEmpty) {
      await context.read<GlobalState>().sendAnswersToServer(context);
      await context.read<GlobalState>().getSummaries();
      context.read<GlobalState>().answers.clear();
    }
  }

  void moveToConclusion() {
    context.read<GlobalState>().summaryConclusion = '';
    Navigator.pushNamed(context, '/summary_conclusion');
  }

  void exitApplication() {
    exit(0);
  }

  void moveToQuestionnaire() {
    context.read<GlobalState>().answers.clear();
    context.read<GlobalState>().summaries.clear();
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const Expanded(
            child: ShowSummaries(),
          ),
          const SizedBox(height: 20),
          /*
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: moveToConclusion,
              child: const Text('Näytä yhteenveto kaikista tiivistelmistä'),
            ),
          ),
          */
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: moveToQuestionnaire,
              child: const Text('Tee kysely uudelleen'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: exitApplication,
              child: const Text('Sulje sovellus'),
            ),
          ),
        ],
      ),
    );
  }
}
