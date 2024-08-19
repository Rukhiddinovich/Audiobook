part of 'audiobook_bloc.dart';


enum PlaybackMode {
  shuffle,
  repeatAll,
  repeatSingle,
}

enum ShuffleType { off, all, one }


class AudiobookState extends Equatable {
  final FormStatus status;
  final AudiobookModel? audiobookModel;
  final DataAudiobookModel? dataAudiobookModel;
  final bool isPlaying;
  final bool isShuffleEnabled;
  final String? errorMessage;
  final int currentIndex;
  final Map<int, double> volumeByIndex;
  final PlaybackMode playbackMode;
  final ShuffleType shuffleType;

  const AudiobookState({
    this.status = FormStatus.initial,
    this.dataAudiobookModel,
    this.audiobookModel,
    this.currentIndex=-1,
    this.isPlaying = false,
    this.isShuffleEnabled = false,
    this.errorMessage,
    this.volumeByIndex = const {},
    this.playbackMode = PlaybackMode.repeatAll,
    this.shuffleType = ShuffleType.off,
  });

  AudiobookState copyWith({
    FormStatus? status,
    AudiobookModel? audiobookModel,
    DataAudiobookModel? dataAudiobookModel,
    bool? isPlaying,
    bool? isShuffleEnabled,
    String? errorMessage,
    int? currentIndex,
    Map<int, double>? volumeByIndex,
    PlaybackMode? playbackMode,
    ShuffleType? shuffleType,
  }) {
    return AudiobookState(
      status: status ?? this.status,
      audiobookModel: audiobookModel ?? this.audiobookModel,
      dataAudiobookModel: dataAudiobookModel ?? this.dataAudiobookModel,
      isPlaying: isPlaying ?? this.isPlaying,
      isShuffleEnabled: isShuffleEnabled ?? this.isShuffleEnabled,
      errorMessage: errorMessage ?? this.errorMessage,
      currentIndex: currentIndex ?? this.currentIndex,
      volumeByIndex: volumeByIndex ?? this.volumeByIndex,
      playbackMode: playbackMode ?? this.playbackMode,
      shuffleType: shuffleType ?? this.shuffleType,
    );
  }

  @override
  List<Object?> get props => [
    status,
    audiobookModel,
    dataAudiobookModel,
    isPlaying,
    isShuffleEnabled,
    errorMessage,
    currentIndex,
    volumeByIndex,
    playbackMode,
    shuffleType,
  ];
}
