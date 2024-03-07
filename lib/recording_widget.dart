import 'package:flutter/material.dart';
import 'package:medical_questionnaire/MyRecorder.dart';
import 'package:http/http.dart' as http;

class RecordingWidget extends StatefulWidget {
  final String title;

  const RecordingWidget({Key? key, required this.title}) : super(key: key);

  @override
  _RecordingWidgetState createState() => _RecordingWidgetState();
}

class _RecordingWidgetState extends State<RecordingWidget> {
  bool _isRecording = false;
  final MyRecorder myRecorder = MyRecorder();

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
    var uri = Uri.parse('http://127.0.0.1:5000/stt');

    // multipart request
    var request = http.MultipartRequest('POST', uri);

    // Attach the file to the request
    request.files.add(await http.MultipartFile.fromPath(
        'speech', myRecorder.mostRecentSpeech));

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        print('File uploaded successfully');
      } else {
        print('File upload failed with status ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading file: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isRecording
                ? const Text('Recording')
                : const Text('Not recording'),
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
                        tooltip: 'Waiting for answer',
                        child: const Icon(Icons.block),
                      )
                    : FloatingActionButton(
                        onPressed: _sendMessage,
                        tooltip: 'Send message',
                        child: const Icon(Icons.arrow_forward_rounded),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
