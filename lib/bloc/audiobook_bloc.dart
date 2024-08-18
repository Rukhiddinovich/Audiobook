import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:uic_task/utils/constants.dart';
import 'package:uic_task/utils/form_status.dart';
import 'package:uic_task/data/model/audiobook_model.dart';
import 'package:uic_task/data/repository/api_repository.dart';
import 'package:uic_task/data/service/api_service.dart';

part 'audiobook_event.dart';

part 'audiobook_state.dart';

class AudiobookBloc extends Bloc<AudiobookEvent, AudiobookState> {
  final ApiService apiService = ApiService();
  final ApiRepository apiRepository;
  late final AudioPlayer audioPlayer;
  late ConcatenatingAudioSource playlist;

  AudiobookBloc()
      : apiRepository = ApiRepository(apiService: ApiService()),
        super(const AudiobookState()) {
    audioPlayer = AudioPlayer();

    // Handle player state stream events
    audioPlayer.playerStateStream.listen((event) {
      add(StreamPlayerEvent(isPlaying: event.playing));
    });

    // Handle stream player event
    on<StreamPlayerEvent>((event, emit) {
      emit(state.copyWith(isPlaying: event.isPlaying));
    });

    // Handle the GetAudiobooksDataEvent
    on<GetAudiobooksDataEvent>((event, emit) async {
      emit(state.copyWith(status: FormStatus.loading));
      try {
        final audiobookModel = await apiRepository.getAudiobooks();
        emit(state.copyWith(
          status: FormStatus.success,
          audiobookModel: audiobookModel,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: FormStatus.error,
          errorMessage: e.toString(),
        ));
      }
    });

    // Handle the LoadAudioEvent
    on<LoadAudioEvent>((event, emit) async {
      emit(state.copyWith(
        currentIndex: event.index,
        isPlaying: false,
      ));
      try {
        final previewUrl = event.previewUrl;
        if (previewUrl == null || previewUrl.isEmpty) {
          throw Exception("Audio preview URL is not available.");
        }
        myPrint("Loading audio from URL: $previewUrl");
        playlist = ConcatenatingAudioSource(
          children: [
            AudioSource.uri(
              Uri.parse(previewUrl),
              tag: MediaItem(
                id: state.audiobookModel?.data?[event.index!].id.toString() ?? "",
                title: state.audiobookModel?.data?[event.index!].title ?? "",
                artist: state.audiobookModel?.data?[event.index!].artist?.name ?? "",
                album: state.audiobookModel?.data?[event.index!].album?.title ?? "",
                artUri: Uri.parse(state.audiobookModel?.data?[event.index!].album?.cover ?? "",),
                duration: const Duration(minutes: 5),
              ),
            ),
          ],
        );
        await audioPlayer.setAudioSource(playlist);
        emit(state.copyWith(status: FormStatus.success));
        await audioPlayer.play();
        emit(state.copyWith(isPlaying: true));
      } catch (e) {
        emit(
          state.copyWith(status: FormStatus.error, errorMessage: e.toString()),
        );
      }
    });

    // Handle the PlayPauseEvent
    on<PlayPauseEvent>((event, emit) async {
      final isPlaying = audioPlayer.playing;

      if (isPlaying) {
        await audioPlayer.pause();
        emit(state.copyWith(isPlaying: false));
      } else {
        await audioPlayer.play();
        emit(state.copyWith(isPlaying: true));
      }
    });

    // Handle the SkipToNextEvent
    on<SkipToNextEvent>((event, emit) async {
      final currentIndex = state.currentIndex;
      final totalItems = state.audiobookModel?.data?.length ?? 0;

      if (currentIndex < totalItems - 1) {
        final nextIndex = currentIndex + 1;
        final nextPreviewUrl = state.audiobookModel?.data?[nextIndex].preview;

        if (nextPreviewUrl != null) {
          await audioPlayer.pause();
          add(LoadAudioEvent(previewUrl: nextPreviewUrl, index: nextIndex));
        }
      } else {
        final firstPreviewUrl = state.audiobookModel?.data?.first.preview;

        if (firstPreviewUrl != null) {
          await audioPlayer.pause();
          add(LoadAudioEvent(previewUrl: firstPreviewUrl, index: 0));
        }
      }
    });

    // Handle the SkipToPreviousEvent
    on<SkipToPreviousEvent>((event, emit) async {
      final currentIndex = state.currentIndex;
      if (currentIndex > 0) {
        final previousIndex = currentIndex - 1;
        final previousPreviewUrl =
            state.audiobookModel?.data?[previousIndex].preview;

        if (previousPreviewUrl != null) {
          await audioPlayer.pause();
          add(LoadAudioEvent(
              previewUrl: previousPreviewUrl, index: previousIndex));
        }
      } else {
        await audioPlayer.seek(Duration.zero);
      }
    });

    // Handle the ToggleShuffleEvent
    on<ToggleShuffleEvent>((event, emit) async {
      final enableShuffle = !audioPlayer.shuffleModeEnabled;
      await audioPlayer.setShuffleModeEnabled(enableShuffle);
      emit(state.copyWith(isShuffleEnabled: enableShuffle));
    });

    // Handle the DisposeEvent
    on<DisposeEvent>((event, emit) {
      audioPlayer.dispose();
    });

    // Handle the ToggleVolumeEvent
    on<ToggleVolumeEvent>((event, emit) async {
      final currentVolume = state.volumeByIndex[event.index] ?? 1.0;
      final newVolume = currentVolume > 0 ? 0.0 : 1.0;
      if (state.currentIndex == event.index) {
        await audioPlayer.setVolume(newVolume);
      }
      final updatedVolumeByIndex = Map<int, double>.from(state.volumeByIndex);
      updatedVolumeByIndex[event.index] = newVolume;
      emit(state.copyWith(volumeByIndex: updatedVolumeByIndex));
    });

    // on<StopAudioEvent>((event,emit)async{
    //   await audioPlayer.stop();
    //   emit(state.copyWith(isPlaying: false));
    // });

    on<UpdateAudiobookModelEvent>((event, emit) async {
      emit(state.copyWith(audiobookModel: event.audiobookModel));
    });

    on<CurrentIndexChangeEvent>((event, emit) async {
      emit(state.copyWith(currentIndex: event.index));
    });
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
