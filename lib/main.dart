import 'package:flutter/material.dart';
import 'package:medical_questionnaire/Questions.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
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
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
      // Creates a key that is equal only to itself.
      body: Questions(key: UniqueKey()),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<GlobalState>().getQuestions,
        tooltip: 'Hae lista',
        child: const Icon(Icons.add),
      ),
    );
  }
}
