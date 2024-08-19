import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uic_task/cubit/connectivity_cubit.dart';
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
  final ConnectivityCubit connectivityCubit;
  late final AudioPlayer audioPlayer;
  late ConcatenatingAudioSource playlist;

  AudiobookBloc({
    required this.connectivityCubit,
  })  : apiRepository = ApiRepository(apiService: ApiService()),
        super(const AudiobookState()) {
    audioPlayer = AudioPlayer();

    audioPlayer.playerStateStream.listen((event) {
      add(StreamPlayerEvent(isPlaying: event.playing));
    });

    on<StreamPlayerEvent>((event, emit) {
      emit(state.copyWith(isPlaying: event.isPlaying));
    });

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

    on<GetDownloadedAudiobooksEvent>((event, emit) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String>? audiobookJsonList =
            prefs.getStringList('downloaded_audiobooks') ?? [];
        if (audiobookJsonList.isNotEmpty) {
          List<DataAudiobookModel> listDataAudiobookModel = [];
          for (String jsonStr in audiobookJsonList) {
            DataAudiobookModel dataAudiobookModel =
                DataAudiobookModel.fromJson(jsonDecode(jsonStr));
            listDataAudiobookModel.add(dataAudiobookModel);
          }
          AudiobookModel audiobookModel =
              AudiobookModel(data: listDataAudiobookModel);
          myPrint("saveListDataAudiobookModel: -----------> $listDataAudiobookModel");
          emit(state.copyWith(
            status: FormStatus.success,
            audiobookModel: audiobookModel,
          ));
        } else {
          emit(
              state.copyWith(status: FormStatus.success, audiobookModel: null));
        }
      } catch (e) {
        emit(state.copyWith(
          status: FormStatus.error,
          errorMessage: e.toString(),
        ));
      }
    });

    on<SaveDownloadedAudiobookEvent>((event, emit) async {
      try {
        if (audioPlayer.playing) {
          await audioPlayer.pause();
        }
        Directory appDocDir = await getApplicationDocumentsDirectory();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String>? audiobookJsonList =
            prefs.getStringList('downloaded_audiobooks') ?? [];
        myPrint("audiobookJsonList: -----------> $audiobookJsonList");
        String appDocPath = appDocDir.path;
        String fileName = '${event.dataAudiobookModel.title}.mp3';
        String filePath = '$appDocPath/$fileName';
        Dio dio = Dio();
        List<DataAudiobookModel> saveListDataAudiobookModel = [];
        for (String jsonStr in audiobookJsonList) {
          DataAudiobookModel dataAudiobookModel =
              DataAudiobookModel.fromJson(jsonDecode(jsonStr));
          saveListDataAudiobookModel.add(dataAudiobookModel);
        }
        if (saveListDataAudiobookModel
            .any((element) => element.id == event.dataAudiobookModel.id)) {
          myPrint("${event.dataAudiobookModel.title} <--------- Already downloaded!");
          emit(state.copyWith(status: FormStatus.success));
          return;
        } else {
          await dio.download(event.dataAudiobookModel.preview!, filePath);
          DataAudiobookModel updatedAudiobook =
              event.dataAudiobookModel.copyWith(
            preview: filePath,
          );
          List<String>? listDownloadedAudiobooks =
              prefs.getStringList('downloaded_audiobooks') ?? [];
          listDownloadedAudiobooks.add(jsonEncode(updatedAudiobook.toJson()));
          await prefs.setStringList(
              'downloaded_audiobooks', listDownloadedAudiobooks);
          myPrint('${updatedAudiobook.title} <--------- has been downloaded!');
          emit(state.copyWith(status: FormStatus.success));
        }
      } catch (e) {
        emit(state.copyWith(
          status: FormStatus.error,
          errorMessage: e.toString(),
        ));
      }
    });

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
                id: state.audiobookModel?.data?[event.index!].id.toString() ??
                    "",
                title: state.audiobookModel?.data?[event.index!].title ?? "",
                artist:
                    state.audiobookModel?.data?[event.index!].artist?.name ??
                        "",
                album: state.audiobookModel?.data?[event.index!].album?.title ??
                    "",
                artUri: Uri.parse(
                  state.audiobookModel?.data?[event.index!].album?.cover ?? "",
                ),
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

    on<ToggleShuffleEvent>((event, emit) async {
      final currentMode = state.playbackMode;
      PlaybackMode newMode;
      ShuffleType newShuffleType;
      switch (currentMode) {
        case PlaybackMode.shuffle:
          newMode = PlaybackMode.repeatAll;
          newShuffleType = ShuffleType.off;
          await audioPlayer.setShuffleModeEnabled(true);
          break;
        case PlaybackMode.repeatAll:
          newMode = PlaybackMode.repeatSingle;
          newShuffleType = ShuffleType.all;
          break;
        case PlaybackMode.repeatSingle:
          newMode = PlaybackMode.shuffle;
          newShuffleType = ShuffleType.one;
          await audioPlayer.setShuffleModeEnabled(true);
          break;
        default:
          newMode = PlaybackMode.shuffle;
          newShuffleType = ShuffleType.one;
          await audioPlayer.setShuffleModeEnabled(true);
          break;
      }
      emit(state.copyWith(
        playbackMode: newMode,
        shuffleType: newShuffleType,
      ));
    });

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
