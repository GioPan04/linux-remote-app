import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/providers/providers.dart';
import 'package:linux_remote_app/screens/remote.dart';
import 'package:linux_remote_app/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const Home(),
          '/mouse': (context) => const RemoteScreen()
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FocusNode _inputFocus;

  @override
  void initState() {
    super.initState();
    _inputFocus = FocusNode();
  }

  @override
  void dispose() {
    _inputFocus.dispose();
    super.dispose();
  }

  void _showKeyboard(BuildContext context) {
    if (_inputFocus.hasFocus) {
      FocusScope.of(context).unfocus();
    } else {
      FocusScope.of(context).requestFocus(_inputFocus);
    }
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Linux Remote"),
        actions: [
          IconButton(
            onPressed: () => _showKeyboard(context),
            icon: const Icon(Icons.keyboard),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Remote control"),
            onTap: () => Navigator.of(context).pushNamed('/mouse'),
          ),
        ],
      ),
    );
  }
}
