import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/models/message.dart';

class SocketNotifier extends StateNotifier<Socket?> {
  final GlobalKey<NavigatorState> navigatorKey;

  SocketNotifier({required this.navigatorKey}) : super(null);

  Future<void> connect() async {
    try {
      final Socket socket = await Socket.connect('desktop.pangio.lan', 1234);
      state = socket;
      socket.listen(_onMessage);
    } catch (e) {
      print("Can't connect to socket");
    }
  }

  void _onMessage(List<int> event) {}

  Future<void> sendMessage(Message message) {
    if (state == null) return Future.value();

    state!.add(message.toBytes());
    return state!.flush();
  }
}
