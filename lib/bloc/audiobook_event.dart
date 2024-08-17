part of 'audiobook_bloc.dart';

abstract class AudiobookEvent {}

class GetAudiobooksDataEvent extends AudiobookEvent {}

class LoadAudioEvent extends AudiobookEvent {
  final String? previewUrl;
  final int? index;

  LoadAudioEvent({this.previewUrl, this.index});
}

class PlayPauseEvent extends AudiobookEvent {}

class SkipToNextEvent extends AudiobookEvent {
  final int id;

  SkipToNextEvent({required this.id});
}

class SkipToPreviousEvent extends AudiobookEvent {}

class ToggleShuffleEvent extends AudiobookEvent {}

class DisposeEvent extends AudiobookEvent {}

class StreamPlayerEvent extends AudiobookEvent{
  final bool isPlaying;

  StreamPlayerEvent({required this.isPlaying});
}

class ToggleVolumeEvent extends AudiobookEvent{
  final int index;

  ToggleVolumeEvent( this.index);
}
