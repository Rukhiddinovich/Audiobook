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

class CurrentIndexChangeEvent extends AudiobookEvent {
  final int index;

  CurrentIndexChangeEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class SaveDownloadedAudiobookEvent extends AudiobookEvent {
  final DataAudiobookModel dataAudiobookModel;
  SaveDownloadedAudiobookEvent({required this.dataAudiobookModel});

  @override
  List<Object> get props => [dataAudiobookModel];
}

class GetDownloadedAudiobooksEvent extends AudiobookEvent {
  @override
  List<Object> get props => [];
}
