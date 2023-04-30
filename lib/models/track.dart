import 'package:linux_remote_app/models/message.dart';

class Track extends MessagePayload {
  final String? title;
  final String? album;
  final List<String>? artists;

  Track({this.title, this.album, this.artists});

  factory Track.fromJson(Map<String, dynamic> data) {
    return Track(
      title: data['title'] as String,
      album: data['album'] as String,
      artists: (data['artists'] as List<dynamic>).cast<String>(),
    );
  }

  @override
  Map<String, dynamic>? toJson() => null;
}
