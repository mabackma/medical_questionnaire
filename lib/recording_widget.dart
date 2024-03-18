import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_questionnaire/MyRecorder.dart';
import 'package:http/http.dart' as http;
import 'package:medical_questionnaire/providers/global_state.dart';
import 'package:medical_questionnaire/user_answer_widget.dart';
import 'package:provider/provider.dart';

class RecordingWidget extends StatefulWidget {
  final String questionId;
  const RecordingWidget({required this.questionId, Key? key}) : super(key: key);

  @override
  _RecordingWidgetState createState() => _RecordingWidgetState();
}

class _RecordingWidgetState extends State<RecordingWidget>
    with AutomaticKeepAliveClientMixin {
  bool _canRecord = true;
  bool _isRecording = false;
  final MyRecorder myRecorder = MyRecorder();
  late String _questionId;
  String _userAnswer = '';

  @override
  void initState() {
    super.initState();
    _questionId = widget.questionId; // Initialize _questionId
  }

  // This mixin is used to keep the state of the widget alive
  // even when the user scrolls away from the widget.
  @override
  bool get wantKeepAlive => true;

  void _toggleRecord() {
    setState(() {
      if (_canRecord) {
        _isRecording = !_isRecording;
      }
    });

    if (_isRecording && _canRecord) {
      myRecorder.recordAudio();
    } else if (!_isRecording && _canRecord) {
      myRecorder.stopRecordingAudio();
      _sendMessage();
    }
  }

  void _sendMessage() async {
    _canRecord = false;
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

      if (response.statusCode == 200) {
        print('File uploaded successfully');
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);

        // Update the user's answer on the screen.
        setState(() {
          _userAnswer = jsonResponse['user_answer'];
          addUserAnswer(_questionId, _userAnswer, context);
          _canRecord = true;
        });
      } else {
        print('File upload failed with status ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading file: $error');
    }
  }

  // Method to save the question id and the user answer.
  void addUserAnswer(
      String questionId, String userAnswer, BuildContext context) {
    final answer = {
      'question_id': questionId,
      'user_answer': userAnswer,
    };

    final globalState = Provider.of<GlobalState>(context, listen: false);
    // Remove any existing answer for the same question
    globalState.answers.removeWhere((ans) => ans['question_id'] == questionId);
    // Add the new answer
    globalState.answers.add(answer);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FloatingActionButton(
          onPressed: _toggleRecord,
          backgroundColor: _isRecording ? Colors.red : Colors.blue,
          tooltip: _isRecording ? 'Lopeta äänittäminen' : 'Äänitä puhetta',
          child: _isRecording
              ? const Icon(
                  Icons.volume_up,
                )
              : (!_canRecord
                  ? const Icon(Icons.mic_off)
                  : const Icon(Icons.mic)),
        ),
        UserAnswerWidget(
          questionId: _questionId,
          userAnswer: _userAnswer,
        ),
      ],
    );
  }
}
