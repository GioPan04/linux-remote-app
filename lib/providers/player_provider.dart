import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/models/message.dart';
import 'package:linux_remote_app/models/track.dart';
import 'package:linux_remote_app/providers/audio_service_provider.dart';
import 'package:linux_remote_app/providers/providers.dart';
import 'package:linux_remote_app/providers/socket_provider.dart';

class PlayerState {
  final Track? currentTrack;
  final bool isPlaying;

  PlayerState({this.currentTrack, this.isPlaying = false});
}

class PlayerNotifier extends StateNotifier<PlayerState> {
  final Ref ref;

  PlayerNotifier(this.ref) : super(PlayerState());

  void handleMessage(Message message) {
    switch (message.target) {
      case 'player:paused':
        state = PlayerState(currentTrack: state.currentTrack, isPlaying: false);
        break;
      case 'player:playing':
        state = PlayerState(currentTrack: state.currentTrack, isPlaying: true);
        break;
      case 'player:track_changed':
        final Track track = Track.fromJson(message.payload);
        state = PlayerState(currentTrack: track, isPlaying: false);
        _audioHandler.mediaItem.add(MediaItem(
          id: track.title!,
          title: track.title!,
          album: track.album,
          artist: track.artists?.join(', '),
        ));
        break;
    }
  }

  SocketNotifier get _socketNotifier => ref.read(socketProvider.notifier);
  CustomAudioHandler get _audioHandler => ref.read(audioServiceProvider)!;

  void pause() {
    _socketNotifier.sendMessage(const Message('player:pause'));
  }

  void play() {
    _socketNotifier.sendMessage(const Message('player:play'));
  }

  void togglePlay() {
    state.isPlaying ? pause() : pause();
  }

  void previous() {
    _socketNotifier.sendMessage(const Message('player:previous'));
  }

  void next() {
    _socketNotifier.sendMessage(const Message('player:next'));
  }
}
