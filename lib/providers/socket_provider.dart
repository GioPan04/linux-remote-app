import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/models/message.dart';
import 'package:linux_remote_app/models/track.dart';
import 'package:linux_remote_app/providers/player_provider.dart';
import 'package:linux_remote_app/providers/providers.dart';

class SocketNotifier extends StateNotifier<Socket?> {
  final GlobalKey<NavigatorState> navigatorKey;
  final Ref ref;

  SocketNotifier({
    required this.ref,
    required this.navigatorKey,
  }) : super(null);

  Future<void> connect() async {
    try {
      final Socket socket = await Socket.connect('desktop.pangio.lan', 1234);
      state = socket;
      socket.listen(_onMessage);
    } catch (e) {
      print("Can't connect to socket");
    }
  }

  void _onMessage(List<int> event) {
    final Message message = Message.fromBytes(event);
    print("target: ${message.target}: ${message.payload}");

    if (message.target.startsWith('player:')) {
      ref.read(playerProvider.notifier).handleMessage(message);
    }
  }

  Future<void> sendMessage(Message message) {
    if (state == null) return Future.value();

    state!.add(message.toBytes());
    return state!.flush();
  }
}
