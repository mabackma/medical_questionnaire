import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:medical_questionnaire/show_summaries.dart';
import 'package:provider/provider.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  void initState() {
    super.initState();
    context.read<GlobalState>().getSummaries();
  }

  void exitApplication() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ShowSummaries(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: exitApplication,
            child: const Text('Sulje sovellus'),
          ),
        ],
      ),
    );
  }
}
