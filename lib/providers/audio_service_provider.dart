import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/providers/player_provider.dart';
import 'package:linux_remote_app/providers/providers.dart';

class CustomAudioHandler extends BaseAudioHandler {
  final Ref ref;

  PlayerNotifier get _playerNotifier => ref.read(playerProvider.notifier);

  CustomAudioHandler(this.ref) {
    ref.watch(playerProvider.notifier).addListener(_mapState);
  }

  Future<void> play() async {
    print("play");
    _playerNotifier.play();
  }

  Future<void> pause() async {
    print("pause");
    _playerNotifier.pause();
  }

  Future<void> skipToPrevious() async {
    print("previous");
    _playerNotifier.previous();
  }

  Future<void> skipToNext() async {
    print("next");
    _playerNotifier.next();
  }

  void _mapState(PlayerState playerState) {
    final state = PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        playerState.isPlaying ? MediaControl.pause : MediaControl.play,
        MediaControl.skipToNext
      ],
      playing: playerState.isPlaying,
      speed: 1,
      processingState: AudioProcessingState.completed,
    );

    playbackState.add(state);
  }
}

class AudioServiceNotifier extends StateNotifier<CustomAudioHandler?> {
  final Ref ref;

  AudioServiceNotifier(this.ref) : super(null);

  Future<void> init() async {
    state = await AudioService.init(
      builder: () => CustomAudioHandler(ref),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'dev.giopan.linuxremote.player',
        androidNotificationChannelName: 'Player notification',
        androidNotificationChannelDescription:
            'Control remotely the player of your pc',
        androidNotificationOngoing: false,
      ),
    );
  }
}
