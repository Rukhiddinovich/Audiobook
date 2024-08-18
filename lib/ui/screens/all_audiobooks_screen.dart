import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uic_task/bloc/audiobook_bloc.dart';
import 'package:uic_task/cubit/connectivity_cubit.dart';
import 'package:uic_task/ui/route/app_route_part.dart';
import 'package:uic_task/utils/color.dart';
import 'package:uic_task/utils/constants.dart';
import 'package:uic_task/utils/form_status.dart';
import 'package:uic_task/utils/icons.dart';

class AllAudiobooksScreen extends StatefulWidget {
  const AllAudiobooksScreen({
    super.key,
    required this.isConnect,
  });

  final bool isConnect;

  @override
  State<AllAudiobooksScreen> createState() => _AllAudiobooksScreenState();
}

class _AllAudiobooksScreenState extends State<AllAudiobooksScreen> {
  int countSet = 0;
  late AudiobookBloc bloc;
  late ConnectivityCubit connectivityCubit;

  Future<void> _init() async {
    if (widget.isConnect == false) {
      myPrint("disconnected-----------------");
      bloc.add(GetDownloadedAudiobooksEvent());
      if (Platform.isIOS && countSet == 0) {
        countSet++;
      }
    } else {
      myPrint("connected-----------------");
      bloc.add(GetAudiobooksDataEvent());
    }
    connectivityCubit.stream.listen((connectivityStatus) {
      if (connectivityStatus == ConnectivityStatus.disconnected) {
        myPrint("disconnected-----------------");
        bloc.add(GetDownloadedAudiobooksEvent());
        if (Platform.isIOS && countSet == 0) {
          countSet++;
        }
      } else if (connectivityStatus == ConnectivityStatus.connected ) {
        myPrint("connected-----------------");
        bloc.add(GetAudiobooksDataEvent());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    connectivityCubit = context.read<ConnectivityCubit>();
    bloc = context.read<AudiobookBloc>();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: SvgPicture.asset(
                AppIcons.audiobookLogo,
                height: 50.h,
                width: 50.w,
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Audio ',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                  color: AppColors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Books',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 24.sp,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<AudiobookBloc, AudiobookState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.status == FormStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Error"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == FormStatus.loading &&
              state.audiobookModel == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state.status == FormStatus.success) {
            if (state.audiobookModel == null) {
              return const Center(child: Text("Model bo'sh qaytdi"));
            }
            return ReorderableListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemCount: state.audiobookModel?.data?.length ?? 0,
              itemBuilder: (context, index) {
                final audiobook = state.audiobookModel?.data?[index];
                final isPlaying =
                    state.currentIndex == index && state.isPlaying;
                return Padding(
                  key: Key(index.toString()),
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.c1C1C4D,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(16.r),
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {
                          context
                              .read<AudiobookBloc>()
                              .add(CurrentIndexChangeEvent(index));
                          Navigator.pushNamed(
                            context,
                            RouteNames.audiobookScreen,
                            arguments: [audiobook, index],
                          );
                        },
                        borderRadius: BorderRadius.circular(16.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10.h),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: 100.w,
                                    height: 80.h,
                                    errorWidget:
                                        (context, error, stackTrace) =>
                                            Container(
                                      width: 100.w,
                                      height: 80.h,
                                      color: AppColors.c1C1C4D,
                                    ), imageUrl: audiobook?.artist?.pictureMedium ?? "",
                                  ),
                                ),
                                title: Text(
                                  audiobook?.title ?? "Unknown name",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.cF5F5FA,
                                  ),
                                ),
                                subtitle: Text(
                                  audiobook?.artist?.name ?? "Unknown name",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.cEBEBF5,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: isPlaying
                                        ? () {
                                            context
                                                .read<AudiobookBloc>()
                                                .add(ToggleVolumeEvent(index));
                                          }
                                        : null,
                                    icon: Icon(
                                      state.volumeByIndex[index] == 0
                                          ? CupertinoIcons.volume_mute
                                          : CupertinoIcons.volume_down,
                                      color: isPlaying
                                          ? AppColors.white
                                          : Colors.grey,
                                      size: 26.r,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
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
                                            if (state.currentIndex == index) {
                                              context
                                                  .read<AudiobookBloc>()
                                                  .add(PlayPauseEvent());
                                            } else {
                                              context
                                                  .read<AudiobookBloc>()
                                                  .add(LoadAudioEvent(
                                                    previewUrl:
                                                        audiobook?.preview,
                                                    index: index,
                                                  ));
                                            }
                                          },
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Icon(
                                              isPlaying
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
                                      if (audiobook != null) {
                                        context
                                            .read<AudiobookBloc>()
                                            .add(SaveDownloadedAudiobookEvent(
                                              dataAudiobookModel: audiobook,
                                            ));
                                      }
                                    },
                                    icon: Icon(
                                      CupertinoIcons.square_arrow_down,
                                      color: AppColors.white,
                                      size: 26.r,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              onReorder: (oldIndex, newIndex) async {
                if (oldIndex < newIndex) newIndex -= 1;
                final isPlayingCurrentItem = state.currentIndex == oldIndex;
                final movedItem =
                    state.audiobookModel?.data?.removeAt(oldIndex);
                if (movedItem != null) {
                  state.audiobookModel?.data?.insert(newIndex, movedItem);
                  final prefs = await SharedPreferences.getInstance();
                  final order = state.audiobookModel!.data!
                      .map((a) => a.id.toString())
                      .toList();
                  await prefs.setStringList('audiobook_order', order);
                  if (isPlayingCurrentItem) {
                    context
                        .read<AudiobookBloc>()
                        .add(CurrentIndexChangeEvent(newIndex));
                  }
                }
              },
            );
          } else if (state.status == FormStatus.error) {
            return Center(
              child: Text(
                state.errorMessage ?? "Error",
                style: TextStyle(color: Colors.red, fontSize: 16.sp),
              ),
            );
          } else {
            myPrint("AudiobookModel-------> ${state.audiobookModel}");
            myPrint("Status-------> ${state.status}");
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
