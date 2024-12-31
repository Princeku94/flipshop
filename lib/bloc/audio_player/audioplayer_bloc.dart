// BLoC Implementation

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/song_model.dart';
import 'audioplayer_event.dart';
import 'audioplayer_state.dart';
import 'package:just_audio/just_audio.dart' as justaudio;

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final List<Song> songs;
  final justaudio.AudioPlayer audioPlayer;

  AudioPlayerBloc({required this.songs})
      : audioPlayer = justaudio.AudioPlayer(),
        super(
            AudioPlayerState(currentIndex: 0, currentDuration: Duration.zero)) {
    on<PlayNext>((event, emit) => _playNext(emit));
    on<PlayPrevious>((event, emit) => _playPrevious(emit));

    on<UpdateDuration>((event, emit) {
      emit(AudioPlayerState(
        currentIndex: state.currentIndex,
        currentDuration: event.currentDuration,
      ));
    });

    audioPlayer.positionStream.listen((position) {
      add(UpdateDuration(position));
    });
    _loadCurrentSong();
  }

  void _playNext(Emitter<AudioPlayerState> emit) {
    int nextIndex = (state.currentIndex + 1) % songs.length;
    emit(AudioPlayerState(
        currentIndex: nextIndex, currentDuration: Duration.zero));
    _loadCurrentSong();
  }

  void _playPrevious(Emitter<AudioPlayerState> emit) {
    int previousIndex = (state.currentIndex - 1 + songs.length) % songs.length;
    emit(AudioPlayerState(
        currentIndex: previousIndex, currentDuration: Duration.zero));
    _loadCurrentSong();
  }

  void stopPlayer() {
    audioPlayer.stop();
  }

  void playPlayer() {
    audioPlayer.play();
  }

  void _loadCurrentSong() async {
    await audioPlayer.setAsset(songs[state.currentIndex].audioPath);
    audioPlayer.play();
  }

  void playerClose() {
    audioPlayer.dispose();
  }
}