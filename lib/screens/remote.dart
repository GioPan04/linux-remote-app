import 'dart:io';

import 'package:flutter/material.dart';
import 'package:linux_remote_app/models/cursor_move.dart';
import 'package:linux_remote_app/models/message.dart';

class RemoteScreen extends StatefulWidget {
  final Socket socket;

  const RemoteScreen({required this.socket, super.key});

  @override
  State<RemoteScreen> createState() => _RemoteScreenState();
}

class _RemoteScreenState extends State<RemoteScreen> {
  void onSwipe(DragUpdateDetails details) async {
    final int x = (details.delta.dx * 1.5).toInt();
    final int y = (details.delta.dy * 1.5).toInt();

    if (x == 0 && y == 0) return;

    final message = Message('uinput:cursor_move', CursorMove(x, y));
    widget.socket.add(message.toBytes());
    await widget.socket.flush();
  }

  void onClick() async {
    const message = Message('uinput:key_press', 0x110);
    widget.socket.add(message.toBytes());
    await widget.socket.flush();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remote control"),
      ),
      body: GestureDetector(
        onPanUpdate: onSwipe,
        onTap: onClick,
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
