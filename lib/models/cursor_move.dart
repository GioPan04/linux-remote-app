import 'package:linux_remote_app/models/message.dart';

class CursorMove extends MessagePayload {
  final int x;
  final int y;

  CursorMove(this.x, this.y);

  factory CursorMove.fromJson(Map<String, dynamic> data) {
    return CursorMove(data['x'] as int, data['y'] as int);
  }

  @override
  Map<String, dynamic> toJson() => {'x': x, 'y': y};
}
