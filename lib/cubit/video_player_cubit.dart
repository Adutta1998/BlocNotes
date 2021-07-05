import 'package:bloc/bloc.dart';
import 'package:video_player/video_player.dart';
part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit(bool playState) : super(VideoPlayerInitial(false));

  void setPlaying(bool playState) {
    emit(VideoPlayerInitial(playState));
  }


}
