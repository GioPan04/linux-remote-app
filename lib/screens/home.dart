import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Linux Remote"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Remote control"),
            onTap: () => Navigator.of(context).pushNamed('/mouse'),
          ),
          ListTile(
            title: const Text("Player"),
            onTap: () => Navigator.of(context).pushNamed('/player'),
          ),
        ],
      ),
    );
  }
}
