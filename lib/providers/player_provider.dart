import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/models/message.dart';
import 'package:linux_remote_app/models/track.dart';
import 'package:linux_remote_app/providers/audio_service_provider.dart';
import 'package:linux_remote_app/providers/providers.dart';
import 'package:linux_remote_app/providers/socket_provider.dart';

class PlayerState {
  final bool isPlaying;
  final Track? currentTrack;
  final double? volume;

  PlayerState({this.currentTrack, this.isPlaying = false, this.volume});
}

class PlayerNotifier extends StateNotifier<PlayerState> {
  final Ref ref;

  PlayerNotifier(this.ref) : super(PlayerState());

  void handleMessage(Message message) {
    switch (message.target) {
      case 'player:paused':
        state = PlayerState(
          currentTrack: state.currentTrack,
          isPlaying: false,
          volume: state.volume,
        );
        break;
      case 'player:playing':
        state = PlayerState(
          currentTrack: state.currentTrack,
          isPlaying: true,
          volume: state.volume,
        );
        break;
      case 'player:volume_changed':
        state = PlayerState(
          currentTrack: state.currentTrack,
          isPlaying: state.isPlaying,
          volume: message.payload as double,
        );
        break;
      case 'player:track_changed':
        final Track track = Track.fromJson(message.payload);
        state = PlayerState(currentTrack: track, isPlaying: state.isPlaying);
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

  void setVolume(double volume) {
    _socketNotifier.sendMessage(Message('player:set_volume', volume));
  }
}
