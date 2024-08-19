part of 'audiobook_screen_part.dart';

class AudiobookScreen extends StatefulWidget {
  const AudiobookScreen({
    super.key,
    required this.datum,
    required this.index,
  });

  final DataAudiobookModel datum;
  final int index;

  @override
  State<AudiobookScreen> createState() => _AudiobookScreenState();
}

class _AudiobookScreenState extends State<AudiobookScreen> {
  @override
  void initState() {
    super.initState();
    myPrint("Index Music ------->${widget.index}");
    context.read<AudiobookBloc>().add(
        LoadAudioEvent(previewUrl: widget.datum.preview, index: widget.index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudiobookBloc, AudiobookState>(
      builder: (context, state) {
        final datum = state.audiobookModel?.data?[state.currentIndex];
        final audiobook = state.audiobookModel?.data?[state.currentIndex];
        final bloc = context.read<AudiobookBloc>();

        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: GlobalAppBar(
            title: Text(
              datum?.title ?? "Unknown name",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AudiobookInfoWidget(
                    imageUrl: datum?.artist?.pictureXl ?? "Unknown image",
                    title: datum?.title ?? "Unknown name",
                    artistName: datum?.artist?.name ?? "Unknown name",
                  ),
                  const SizedBox(height: 20), // Spacing between widgets
                  Padding(
                    padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.w, right: 16.w, top: 16.h, bottom: 20.h),
                        child: Column(
                          children: [
                            StreamBuilder<PositionData>(
                              stream: Rx.combineLatest3<Duration, Duration,
                                  Duration?, PositionData>(
                                bloc.audioPlayer.positionStream,
                                bloc.audioPlayer.bufferedPositionStream,
                                bloc.audioPlayer.durationStream,
                                    (position, bufferedPosition, duration) =>
                                    PositionData(
                                      position,
                                      bufferedPosition,
                                      duration ?? Duration.zero,
                                    ),
                              ),
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                final position =
                                    positionData?.position ?? Duration.zero;
                                final duration =
                                    positionData?.duration ?? Duration.zero;

                                return Column(
                                  children: [
                                    Slider(
                                      min: 0.0,
                                      max: duration.inMilliseconds.toDouble(),
                                      value: position.inMilliseconds
                                          .toDouble()
                                          .clamp(
                                        0.0,
                                        duration.inMilliseconds.toDouble(),
                                      ),
                                      inactiveColor: AppColors.cDDD7FC,
                                      activeColor: AppColors.c4838D1,
                                      onChanged: (value) {
                                        bloc.audioPlayer.seek(Duration(
                                            milliseconds: value.toInt()));
                                      },
                                    ),
                                    SliderTextWidget(
                                      textPosition: formatDuration(position),
                                      textDuration: formatDuration(duration),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 20), // Spacing between widgets
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButtonWidgets(
                                  onPressed: () {
                                    context
                                        .read<AudiobookBloc>()
                                        .add(ToggleShuffleEvent());
                                  },
                                  icon: getShuffleIcon(bloc.state.shuffleType),
                                  iconColor: AppColors.white,
                                ),
                                Expanded(
                                  child: AudioControllerRowWidgets(
                                    leftOnPressed: () {
                                      bloc.add(SkipToPreviousEvent());
                                    },
                                    leftIcon: CupertinoIcons.chevron_left_circle,
                                    onTap: () {
                                      bloc.add(PlayPauseEvent());
                                    },
                                    playPauseIcon: state.isPlaying
                                        ? CupertinoIcons.pause_fill
                                        : CupertinoIcons.play_arrow_solid,
                                    rightIcon: CupertinoIcons.chevron_right_circle,
                                    rightOnPressed: () {
                                      bloc.add(
                                        SkipToNextEvent(id: datum?.id ?? 0),
                                      );
                                    },
                                  ),
                                ),
                                IconButtonWidgets(
                                  onPressed: () {
                                    if (audiobook != null) {
                                      context
                                          .read<AudiobookBloc>()
                                          .add(SaveDownloadedAudiobookEvent(
                                        dataAudiobookModel: audiobook,
                                      ));
                                    }
                                  },
                                  icon: CupertinoIcons.tray_arrow_down,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  IconData getShuffleIcon(ShuffleType shuffleType) {
    switch (shuffleType) {
      case ShuffleType.all:
        return CupertinoIcons.shuffle;
      case ShuffleType.one:
        return CupertinoIcons.repeat_1;
      default:
        return CupertinoIcons.repeat;
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
