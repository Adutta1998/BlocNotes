part of 'video_player_cubit.dart';

abstract class VideoPlayerState {}

class VideoPlayerInitial extends VideoPlayerState{
  bool playState;
  VideoPlayerInitial(this.playState);
}
