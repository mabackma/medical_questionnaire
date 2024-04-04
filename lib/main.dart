import 'package:flutter/material.dart';
import 'package:medical_questionnaire/InputPage.dart';
import 'package:medical_questionnaire/SummaryPage.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:medical_questionnaire/show_questions.dart';
import 'package:provider/provider.dart';

void main() {
  // Run the application with the global state provider.
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GlobalState()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Questionnaire',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          backgroundColor: const Color.fromARGB(255, 26, 94, 129),
        ),
        useMaterial3: true,
      ),
      // Routes for the application
      initialRoute: '/',
      routes: {
        '/': (context) => const InputPage(),
        '/home': (context) =>
            const MyHomePage(title: 'Hyvinvointikyselylomake'),
        '/summary': (context) => const SummaryPage(title: 'Kyselyn yhteenveto'),
      },
    );
  }
}

// The home page of the application.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// The state of the home page.
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<GlobalState>().getQuestionnaire();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: ShowQuestions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/summary');
        },
        tooltip: 'Lähetä vastaukset',
        child: const Icon(Icons.send),
      ),
    );
  }
}
