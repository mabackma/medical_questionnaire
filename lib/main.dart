import 'package:flutter/material.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
            backgroundColor: Colors.deepPurple[200]),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Medical Questionnaire Home Page'),
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
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Creates a key that is equal only to itself.
        child: ShowQuestions(key: UniqueKey()),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<GlobalState>().getQuestionnaire(),
            tooltip: 'Hae lista',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16), // Add spacing between buttons
          FloatingActionButton(
            onPressed: () => context.read<GlobalState>().sendAnswersToServer(),
            tooltip: 'Lähetä vastaukset',
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
