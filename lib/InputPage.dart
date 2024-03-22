import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:provider/provider.dart';

class InputPage extends StatelessWidget {
  const InputPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();

    void handleButtonPress(BuildContext context) {
      // Add the user name to the global state
      final globalState = Provider.of<GlobalState>(context, listen: false);
      globalState.user = _textEditingController.text;

      // Navigate to the home page
      Navigator.pushReplacementNamed(context, '/home');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Käyttäjän tiedot'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textEditingController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Enter your text here', // Add hint text
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => handleButtonPress(context),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
