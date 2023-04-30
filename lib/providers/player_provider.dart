import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/models/message.dart';
import 'package:linux_remote_app/models/track.dart';
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
        break;
    }
  }

  SocketNotifier get _socketNotifier => ref.read(socketProvider.notifier);

  void pause() {
    _socketNotifier.sendMessage(const Message('player:pause'));
  }

  void play() {
    _socketNotifier.sendMessage(const Message('player:play'));
  }
}
