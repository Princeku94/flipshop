abstract class AudioPlayerEvent {}

class PlayNext extends AudioPlayerEvent {}

class PlayPrevious extends AudioPlayerEvent {}

class UpdateDuration extends AudioPlayerEvent {
  final Duration currentDuration;
  UpdateDuration(this.currentDuration);
}