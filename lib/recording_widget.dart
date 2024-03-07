import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_questionnaire/MyRecorder.dart';
import 'package:http/http.dart' as http;
import 'package:medical_questionnaire/user_answer_widget.dart';

class RecordingWidget extends StatefulWidget {
  const RecordingWidget({Key? key}) : super(key: key);

  @override
  _RecordingWidgetState createState() => _RecordingWidgetState();
}

class _RecordingWidgetState extends State<RecordingWidget> {
  bool _isRecording = false;
  final MyRecorder myRecorder = MyRecorder();
  String _userAnswer = "the user's answer will appear here";

  void _toggleRecord() {
    setState(() {
      _isRecording = !_isRecording;
    });

    if (_isRecording) {
      myRecorder.recordAudio();
    } else {
      myRecorder.stopRecordingAudio();
    }
  }

  void _sendMessage() async {
    await myRecorder.stopRecordingAudio();
    print(myRecorder.mostRecentSpeech);
    var uri = Uri.parse('http://127.0.0.1:5001/stt');

    // multipart request
    var request = http.MultipartRequest('POST', uri);

    // Attach the file to the request
    request.files.add(await http.MultipartFile.fromPath(
        'speech', myRecorder.mostRecentSpeech));

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        print('File uploaded successfully');
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        setState(() {
          _userAnswer = jsonResponse['user_answer'];
        });
        print(_userAnswer);
      } else {
        print('File upload failed with status ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading file: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _isRecording ? const Text('Recording') : const Text('Not recording'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              onPressed: _toggleRecord,
              tooltip: _isRecording ? 'Stop recording' : 'Record speech',
              child: _isRecording
                  ? const Icon(Icons.mic_off)
                  : const Icon(Icons.mic),
            ),
            _isRecording || myRecorder.mostRecentSpeech.isEmpty
                ? FloatingActionButton(
                    onPressed: () {},
                    tooltip: 'Waiting for speech',
                    child: const Icon(Icons.block),
                  )
                : FloatingActionButton(
                    onPressed: _sendMessage,
                    tooltip: 'Send answer',
                    child: const Icon(Icons.arrow_forward_rounded),
                  ),
          ],
        ),
        UserAnswerWidget(userAnswer: _userAnswer),
      ],
    );
  }
}
