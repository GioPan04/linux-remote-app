import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/providers/audio_service_provider.dart';
import 'package:linux_remote_app/providers/player_provider.dart';
import 'package:linux_remote_app/providers/socket_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final playerProvider = StateNotifierProvider<PlayerNotifier, PlayerState>(
  (ref) => PlayerNotifier(ref),
);
final audioServiceProvider =
    StateNotifierProvider<AudioServiceNotifier, CustomAudioHandler?>(
  (ref) => AudioServiceNotifier(ref),
);
final socketProvider = StateNotifierProvider<SocketNotifier, Socket?>(
  (ref) => SocketNotifier(ref: ref, navigatorKey: navigatorKey),
);
