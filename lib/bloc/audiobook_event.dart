part of 'audiobook_bloc.dart';

abstract class AudiobookEvent extends Equatable {}

class GetAudiobooksDataEvent extends AudiobookEvent {
  @override
  List<Object?> get props => [];
}

class LoadAudioEvent extends AudiobookEvent {
  final String? previewUrl;
  final int? index;

  LoadAudioEvent({this.previewUrl, this.index});

  @override
  List<Object?> get props => [previewUrl, index];
}

class PlayPauseEvent extends AudiobookEvent {
  @override
  List<Object?> get props => [];
}

class SkipToNextEvent extends AudiobookEvent {
  final int id;

  SkipToNextEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class SkipToPreviousEvent extends AudiobookEvent {
  @override
  List<Object?> get props => [];
}

class ToggleShuffleEvent extends AudiobookEvent {
  @override
  List<Object?> get props => [];
}

class DisposeEvent extends AudiobookEvent {
  @override
  List<Object?> get props => [];
}

class StreamPlayerEvent extends AudiobookEvent {
  final bool isPlaying;

  StreamPlayerEvent({required this.isPlaying});

  @override
  List<Object?> get props => [isPlaying];
}

class ToggleVolumeEvent extends AudiobookEvent {
  final int index;

  ToggleVolumeEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class StopAudioEvent extends AudiobookEvent {
  @override
  List<Object> get props => [];
}

class CurrentIndexChangeEvent extends AudiobookEvent {
  final int index;

  CurrentIndexChangeEvent(this.index);

  @override
  List<Object?> get props => [index];
}


class UpdateAudiobookModelEvent extends AudiobookEvent {
  final AudiobookModel audiobookModel;

  UpdateAudiobookModelEvent(this.audiobookModel);

  @override
  List<Object?> get props => [audiobookModel];
}
