import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';

class AudioController extends GetxController {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  final RxBool isPlaying = false.obs;
  final Rx<Duration> currentPosition = Duration.zero.obs;
  final Rx<Duration> totalDuration = Duration.zero.obs;

  StreamSubscription? _positionSub;

  @override
  void onInit() {
    super.onInit();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    if (!_player.isOpen()) {
      await _player.openPlayer();
    }
  }

  Future<void> play(String path) async {
    try {
      await _initPlayer();

      await _player.startPlayer(
        fromURI: path,
        codec: path.endsWith('.mp3') ? Codec.mp3 : Codec.aacADTS,
        whenFinished: () {
          isPlaying.value = false;
          currentPosition.value = Duration.zero;
          totalDuration.value = Duration.zero;
        },
      );

      isPlaying.value = true;

      _positionSub?.cancel();
      _positionSub = _player.onProgress!.listen((event) {
        currentPosition.value = event.position;
        totalDuration.value = event.duration;
      });
    } catch (e) {
      print("Audio play error: $e");
    }
  }

  Future<void> stop() async {
    try {
      await _player.stopPlayer();
    } catch (e) {
      print("Stop error: $e");
    } finally {
      isPlaying.value = false;
      currentPosition.value = Duration.zero;
      totalDuration.value = Duration.zero;
    }
  }

  @override
  void onClose() {
    _positionSub?.cancel();
    _player.closePlayer();
    super.onClose();
  }
}
