import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uic_task/bloc/audiobook_bloc.dart';
import 'package:uic_task/data/model/audiobook_model.dart';
import 'package:uic_task/utils/color.dart';
import 'package:rxdart/rxdart.dart';

class AudiobookScreen extends StatefulWidget {
  const AudiobookScreen({super.key, required this.datum, required this.index});

  final Datum datum;
  final int index;

  @override
  State<AudiobookScreen> createState() => _AudiobookScreenState();
}

class _AudiobookScreenState extends State<AudiobookScreen> {
  @override
  initState() {
    context
        .read<AudiobookBloc>()
        .add(LoadAudioEvent(previewUrl: widget.datum.preview,index: widget.index));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AudiobookBloc, AudiobookState>(
      builder: (context, state) {
        final datum = state.audiobookModel?.data?[state.currentIndex];
        final bloc = context.read<AudiobookBloc>();
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: AppColors.primaryColor,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: AppColors.primaryColor,
            scrolledUnderElevation: 0,
            elevation: 0,
            title: Text(
              datum?.title ?? "Unknown name",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      datum?.artist?.pictureMedium ?? "Unknown image",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 28.h, bottom: 4.h),
                  child: Text(
                    datum?.title ?? "Unknown name",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      color: AppColors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Text(
                  datum?.artist?.name ?? "Unknown name",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: AppColors.white.withOpacity(0.5),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const Spacer(),
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
                              final bufferedPosition =
                                  positionData?.bufferedPosition ??
                                      Duration.zero;

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
                                  Row(
                                    children: [
                                      Text(
                                        formatDuration(position),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                          color: AppColors.c9292A2,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        formatDuration(duration),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                          color: AppColors.c9292A2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  bloc.add(ToggleShuffleEvent());
                                },
                                icon: Icon(
                                  Icons.shuffle_rounded,
                                  size: 30.r,
                                  color: bloc.state.isShuffleEnabled
                                      ? AppColors.c4838D1
                                      : AppColors.white,
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        bloc.add(SkipToPreviousEvent());
                                      },
                                      icon: Icon(
                                        CupertinoIcons.chevron_left_circle,
                                        color: AppColors.white,
                                        size: 35.r,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                          color: AppColors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          type: MaterialType.transparency,
                                          child: InkWell(
                                            onTap: () {
                                              bloc.add(PlayPauseEvent());
                                            },
                                            borderRadius:
                                                BorderRadius.circular(100.r),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Icon(
                                                state.isPlaying
                                                    ? CupertinoIcons.pause_fill
                                                    : CupertinoIcons
                                                        .play_arrow_solid,
                                                size: 30.r,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        bloc.add(SkipToNextEvent(id: datum?.id ?? 0));
                                      },
                                      icon: Icon(
                                        CupertinoIcons.chevron_right_circle,
                                        color: AppColors.white,
                                        size: 35.r,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.square_arrow_down,
                                  size: 30.r,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
