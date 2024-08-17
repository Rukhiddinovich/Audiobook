import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uic_task/bloc/audiobook_bloc.dart';
import 'package:uic_task/data/form_status/form_status.dart';
import 'package:uic_task/ui/route/app_route_part.dart';
import 'package:uic_task/utils/color.dart';
import 'package:uic_task/utils/icons.dart';

class AllAudiobooksScreen extends StatelessWidget {
  const AllAudiobooksScreen({super.key});

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
        scrolledUnderElevation: 0,
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
      body: BlocBuilder<AudiobookBloc, AudiobookState>(
        builder: (context, state) {
          final bloc = context.read<AudiobookBloc>();
          if (state.status == FormStatus.loading && state.audiobookModel == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state.status == FormStatus.success) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemCount: state.audiobookModel?.data?.length ?? 0,
              itemBuilder: (context, index) {
                final audiobook = state.audiobookModel?.data![index];
                final isPlaying = state.currentIndex == index && state.isPlaying;
                return Padding(
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
                          Navigator.pushNamed(
                            context,
                            RouteNames.audiobookScreen,
                            arguments: [audiobook, index],
                          );
                        },
                        borderRadius: BorderRadius.circular(16.r),
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.network(
                                    audiobook?.artist?.pictureMedium ?? "",
                                    fit: BoxFit.cover,
                                    width: 100.w,
                                    height: 80.h,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 100.w,
                                      height: 80.h,
                                      color: AppColors.c1C1C4D,
                                    ),
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
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        bloc.add(ToggleVolumeEvent(index));
                                      },
                                      icon: Icon(
                                        state.volumeByIndex[index] == 0 ? CupertinoIcons.volume_mute : CupertinoIcons.volume_down,
                                        color: AppColors.white,
                                        size: 26.r,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                                      child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                          color: AppColors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Material(
                                          borderRadius: BorderRadius.circular(100.r),
                                          type: MaterialType.transparency,
                                          child: InkWell(
                                            onTap: () {
                                              if (state.currentIndex == index) {
                                                bloc.add(PlayPauseEvent());
                                              } else {
                                                bloc.add(LoadAudioEvent(previewUrl: audiobook?.preview, index: index));
                                              }
                                            },
                                            borderRadius: BorderRadius.circular(100.r),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Icon(
                                                isPlaying
                                                    ? CupertinoIcons.pause_fill
                                                    : CupertinoIcons.play_arrow_solid,
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
                                        // Define download button action if needed
                                      },
                                      icon: Icon(
                                        CupertinoIcons.square_arrow_down,
                                        color: AppColors.white,
                                        size: 26.r,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
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
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
