part of 'audiobook_bloc.dart';

class AudiobookState extends Equatable {
  final FormStatus status;
  final AudiobookModel? audiobookModel;
  final bool isPlaying;
  final bool isShuffleEnabled;
  final String? errorMessage;
  final int currentIndex;
  final Map<int, double> volumeByIndex;

  const AudiobookState({
    this.status = FormStatus.initial,
    this.audiobookModel,
    this.currentIndex=-1,
    this.isPlaying = false,
    this.isShuffleEnabled = false,
    this.errorMessage,
    this.volumeByIndex = const {},
  });

  AudiobookState copyWith({
    FormStatus? status,
    AudiobookModel? audiobookModel,
    bool? isPlaying,
    bool? isShuffleEnabled,
    String? errorMessage,
    int? currentIndex,
    Map<int, double>? volumeByIndex,
  }) {
    return AudiobookState(
      status: status ?? this.status,
      audiobookModel: audiobookModel ?? this.audiobookModel,
      isPlaying: isPlaying ?? this.isPlaying,
      isShuffleEnabled: isShuffleEnabled ?? this.isShuffleEnabled,
      errorMessage: errorMessage ?? this.errorMessage,
      currentIndex: currentIndex ?? this.currentIndex,
      volumeByIndex: volumeByIndex ?? this.volumeByIndex,
    );
  }

  @override
  List<Object?> get props => [
    status,
    audiobookModel,
    isPlaying,
    isShuffleEnabled,
    errorMessage,
    currentIndex,
    volumeByIndex
  ];
}
