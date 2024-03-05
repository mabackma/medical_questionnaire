import 'package:flutter/material.dart';
import 'package:list_demo/providers/global_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GlobalState()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Questions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<GlobalState>().getQuestions,
        tooltip: 'Hae lista',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Questions extends StatelessWidget {
  const Questions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final questions = context.watch<GlobalState>().questions.map((question) {
      return Text(question);
    }).toList();

    return questions.isEmpty
        ? const CircularProgressIndicator()
        : ListView(children: questions);
  }
}
