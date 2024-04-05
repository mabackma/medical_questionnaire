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
            SizedBox(
              width: 300.0,
              child: TextField(
                controller: _textEditingController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Anna käyttäjänimesi',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 40.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ikä: ',
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                SizedBox(width: 10.0),
                SizedBox(
                  width: 100.0,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Anna ikäsi',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            const Text(
              'Valitse sukupuolesi: ',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    print('Male icon pressed');
                  },
                  icon: const Icon(
                    Icons.male,
                    color: Colors.lightBlueAccent,
                    size: 40,
                  ),
                ),
                SizedBox(width: 40.0),
                IconButton(
                  onPressed: () {
                    print('Female icon pressed');
                  },
                  icon: const Icon(
                    Icons.female,
                    color: Colors.pinkAccent,
                    size: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () => handleButtonPress(context),
              child: const Text('Lähetä'),
            ),
          ],
        ),
      ),
    );
  }
}
