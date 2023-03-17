import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

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

    widget.socket.add(
        utf8.encode('{"action": ${0x1}, "payload": {"x": $x, "y": $y}}\n'));
    await widget.socket.flush();
  }

  void onClick() async {
    widget.socket
        .add(utf8.encode('{"action": ${0x2}, "payload": {"key": ${0x110}}}\n'));
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
