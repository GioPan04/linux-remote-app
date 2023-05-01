import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/providers/providers.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.read(playerProvider.notifier);
    final state = ref.watch(playerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Player')),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(state.currentTrack?.title ?? 'Unknown'),
          if (state.currentTrack?.album != null)
            Text(state.currentTrack!.album!),
          if (state.currentTrack?.artists != null)
            Text(
              state.currentTrack!.artists!.join(', '),
            ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => player.previous(),
                iconSize: 32,
                icon: const Icon(Icons.skip_previous),
              ),
              IconButton(
                onPressed: () => player.togglePlay(),
                iconSize: 64,
                icon: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow),
              ),
              IconButton(
                onPressed: () => player.next(),
                iconSize: 32,
                icon: const Icon(Icons.skip_next),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
