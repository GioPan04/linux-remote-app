import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_remote_app/providers/providers.dart';
import 'package:linux_remote_app/screens/home.dart';
import 'package:linux_remote_app/screens/player.dart';
import 'package:linux_remote_app/screens/remote.dart';
import 'package:linux_remote_app/screens/settings.dart';
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
          '/home': (context) => const HomeScreen(),
          '/mouse': (context) => const RemoteScreen(),
          '/player': (context) => const PlayerScreen(),
          '/settings': (context) => const SettingsScreen()
        },
      ),
    );
  }
}
