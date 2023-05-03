import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/models/message.dart';
import 'package:linux_remote_app/providers/providers.dart';

class SocketNotifier extends StateNotifier<Socket?> {
  final GlobalKey<NavigatorState> navigatorKey;
  final Ref ref;

  SocketNotifier({
    required this.ref,
    required this.navigatorKey,
  }) : super(null);

  Future<void> connect(String address) async {
    try {
      await state?.close();
    } catch (e) {
      print("Can't close previusly connected socket, going on");
    }

    try {
      final Socket socket = await Socket.connect('desktop.pangio.lan', 1234);
      state = socket;
      utf8.decoder
          .bind(socket)
          .transform(const LineSplitter())
          .listen(_onMessage);
    } catch (e) {
      print("Can't connect to socket");
      print(e);
      rethrow;
    }
  }

  void _onMessage(String event) {
    final Message message = Message.fromJson(jsonDecode(event));
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
