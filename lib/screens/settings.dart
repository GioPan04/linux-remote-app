import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/providers/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _updateAddress(BuildContext context, WidgetRef ref) async {
    final String address = await showDialog(
      context: context,
      builder: (context) => const ServerAddressDialog(),
    );

    final socketNotifier = ref.read(socketProvider.notifier);
    await socketNotifier.connect(address);

    // ignore: use_build_context_synchronously
    Navigator.of(context).popUntil((route) => route.isFirst);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => _updateAddress(context, ref),
            title: const Text('Change server address'),
            subtitle: const Text('Update server address and connect to it'),
          )
        ],
      ),
    );
  }
}

class ServerAddressDialog extends StatelessWidget {
  const ServerAddressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update server address'),
      content: TextField(
        textInputAction: TextInputAction.done,
        onSubmitted: (value) => Navigator.pop(context, value),
        decoration: const InputDecoration(
          labelText: 'Server address',
          hintText: 'yourpc.lan',
        ),
      ),
    );
  }
}
