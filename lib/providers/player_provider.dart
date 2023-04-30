import 'package:linux_remote_app/models/track.dart';

class PlayerState {
  final Track? currentTrack;
  final bool isPlaying;

  PlayerState({this.currentTrack, this.isPlaying = false});
}
