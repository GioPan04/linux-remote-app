import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/models/cursor_move.dart';
import 'package:linux_remote_app/models/message.dart';
import 'package:linux_remote_app/providers/providers.dart';
import 'package:linux_remote_app/providers/socket_provider.dart';

class RemoteScreen extends ConsumerWidget {
  const RemoteScreen({super.key});

  void onSwipe(DragUpdateDetails details, SocketNotifier socket) async {
    final int x = (details.delta.dx * 1.5).toInt();
    final int y = (details.delta.dy * 1.5).toInt();

    if (x == 0 && y == 0) return;

    final message = Message('uinput:cursor_move', CursorMove(x, y));
    socket.sendMessage(message);
  }

  void onClick(SocketNotifier socket) async {
    const message = Message('uinput:key_press', 0x110);
    socket.sendMessage(message);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socketNotifier = ref.read(socketProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Remote control"),
      ),
      body: GestureDetector(
        onPanUpdate: (details) => onSwipe(details, socketNotifier),
        onTap: () => onClick(socketNotifier),
        child: Container(
          color: Colors.transparent,
          child: const Center(
            child: Icon(
              Icons.touch_app,
              size: 48,
            ),
          ),
        ),
      ),
    );
  }
}
