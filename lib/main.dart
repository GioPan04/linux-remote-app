import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:linux_remote_app/components/custom_text_input.dart';
import 'package:linux_remote_app/screens/remote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Socket socket = await Socket.connect('desktop.pangio.lan', 1234);

  runApp(MyApp(socket));
}

class MyApp extends StatelessWidget {
  final Socket socket;

  const MyApp(this.socket, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(socket),
    );
  }
}

class Home extends StatefulWidget {
  final Socket socket;

  const Home(this.socket, {super.key});

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
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RemoteScreen(socket: widget.socket),
              ),
            ),
          )
        ],
      ),
    );
  }
}
