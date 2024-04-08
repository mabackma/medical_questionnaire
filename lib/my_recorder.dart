import 'dart:io';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class MyRecorder {
  late final AudioRecorder _audioRecorder = AudioRecorder();
  static const encoder = AudioEncoder.aacLc;
  RecordConfig config = const RecordConfig(encoder: encoder, numChannels: 1);
  String mostRecentSpeech = '';

  // Records and saves audio
  Future<void> recordAudio() async {
    final path = await _getPath();

    await _audioRecorder.start(config, path: path);
    mostRecentSpeech = path;
  }

  // Stops recording audio
  Future<void> stopRecordingAudio() async {
    await _audioRecorder.stop();
  }

  // Returns the path to the recorded audio file
  Future<String> _getPath() async {
    final dir = await getApplicationDocumentsDirectory();
    const speechDirectory = 'speech_flutter_whisper';

    final speechDirPath = p.join(dir.path, speechDirectory);

    // Ensure the directory exists, create it if not
    await Directory(speechDirPath).create(recursive: true);
    return p.join(
      dir.path,
      speechDirectory,
      'audio_${DateTime.now().millisecondsSinceEpoch}.m4a',
    );
  }
}
