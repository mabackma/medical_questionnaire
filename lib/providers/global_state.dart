import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medical_questionnaire/services/api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class GlobalState extends ChangeNotifier {
  String user = '';
  List<Map<String, dynamic>> questionnaire = [];
  List<Map<String, dynamic>> answers = [];

  // Method to fetch the entire questionnaire from the server
  Future<void> getQuestionnaire() async {
    try {
      questionnaire = await ApiService.getAll();
    } catch (error) {
      print('Error fetching questions: $error');
    }

    // This will trigger a rebuild of the widget.
    notifyListeners();
  }

  // Method to send the answers to the server
  Future<void> sendAnswersToServer() async {
    print('Sending answers to server from user: $user');
    try {
      await ApiService.postAnswers(answers);
      await deleteFilesInDirectory();
    } catch (error) {
      print('Error sending answers: $error');
    }
  }

  // Method to delete all the recordings in the directory
  Future<void> deleteFilesInDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    const speechDirectory = 'speech_flutter_whisper';
    final speechDirPath = p.join(dir.path, speechDirectory);

    print("deleting all files in $speechDirPath");
    final speechDir = Directory(speechDirPath);
    if (await speechDir.exists()) {
      await for (var entity in speechDir.list()) {
        if (entity is File) {
          await entity.delete();
        }
      }
    }
  }
}
