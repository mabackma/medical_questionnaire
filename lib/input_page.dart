import 'package:flutter/material.dart';
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  DateTime? selectedDate = DateTime.now();
  TextEditingController usernameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String gender = '';

  @override
  Widget build(BuildContext context) {
    void handleButtonPress(BuildContext context) {
      // Add the user name to the global state
      final globalState = Provider.of<GlobalState>(context, listen: false);
      globalState.user = {
        'username': usernameController.text,
        'age': ageController.text,
        'gender': gender
      };

      globalState.answerDate = DateFormat.yMMMd().format(selectedDate!);

      // Navigate to the home page
      Navigator.pushReplacementNamed(context, '/home');
    }

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
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
                controller: usernameController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Anna käyttäjänimesi',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Ikä: ',
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: 100.0,
                  child: TextField(
                    controller: ageController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: 'Anna ikäsi',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white),
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
                    gender = 'man';
                  },
                  icon: const Icon(
                    Icons.male,
                    color: Colors.lightBlueAccent,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 40.0),
                IconButton(
                  onPressed: () {
                    gender = 'woman';
                  },
                  icon: const Icon(
                    Icons.female,
                    color: Colors.pinkAccent,
                    size: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => selectDate(context),
                  child: const Text('Select Date'),
                ),
                const SizedBox(width: 40),
                Text(
                  selectedDate != null
                      ? DateFormat.yMMMd().format(selectedDate!)
                      : 'No date selected',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16, // Adjust the font size as needed
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
