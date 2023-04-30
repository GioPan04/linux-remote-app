import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/providers/socket_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final socketProvider = StateNotifierProvider<SocketNotifier, Socket?>(
  (ref) => SocketNotifier(navigatorKey: navigatorKey),
);
