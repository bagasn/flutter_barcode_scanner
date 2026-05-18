import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final _player = AudioPlayer();

  Future<void> play(String assetPath) async {
    if (_player.playing) {
      await _player.stop();
    }
    await _player.setAsset(assetPath);
    await _player.play();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> pause() async {
    await _player.pause();
  }
}
