import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const codec = Codec.aacMP4;

class FlutterSoundExample extends StatefulWidget {
  @override
  _FlutterSoundExampleState createState() => _FlutterSoundExampleState();
}

class _FlutterSoundExampleState extends State<FlutterSoundExample> {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  FlutterSoundPlayer _player = FlutterSoundPlayer();
  String? _filePath;
  bool _isRecorderInitialized = false;
  bool _isRecording = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Permission.microphone.request();
    await Permission.storage.request();

    Directory dir = await getApplicationDocumentsDirectory();
    _filePath = '${dir.path}/flutter_sound_example.aac';

    await _recorder.openRecorder();
    await _player.openPlayer();

    setState(() {
      _isRecorderInitialized = true;
    });
  }

  Future<void> _startRecording() async {
    if (!_isRecorderInitialized) return;
    await _recorder.startRecorder(
      toFile: _filePath,
      codec: codec,
    );
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _playRecording() async {
    if (_filePath == null || _isPlaying) return;

    await _player.startPlayer(
      fromURI: _filePath,
      codec: codec,
      whenFinished: () {
        setState(() => _isPlaying = false);
      },
    );

    setState(() => _isPlaying = true);
  }

  Future<void> _stopPlayback() async {
    await _player.stopPlayer();
    setState(() => _isPlaying = false);
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Sound Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isPlaying ? _stopPlayback : _playRecording,
              child: Text(_isPlaying ? 'Stop Playback' : 'Play Recording'),
            ),
            SizedBox(height: 20),
            if (_filePath != null) Text('Saved at:\n$_filePath'),
          ],
        ),
      ),
    );
  }
}
