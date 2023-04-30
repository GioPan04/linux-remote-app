import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/providers/providers.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Player')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('isPlaying: ${state.isPlaying}'),
            Text('Title: ${state.currentTrack?.title ?? '---'}')
          ],
        ),
      ),
    );
  }
}
