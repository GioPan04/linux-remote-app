import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/providers/providers.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  void init(BuildContext context, WidgetRef ref) async {
    await ref.read(audioServiceProvider.notifier).init();
    final socketNotifier = ref.read(socketProvider.notifier);

    await socketNotifier.connect();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    init(context, ref);

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
