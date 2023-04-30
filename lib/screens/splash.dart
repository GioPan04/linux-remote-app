import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/providers/providers.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socketNotifier = ref.read(socketProvider.notifier);

    socketNotifier
        .connect()
        .then((_) => Navigator.of(context).pushReplacementNamed('/home'));

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
