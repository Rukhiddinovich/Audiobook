import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uic_task/utils/color.dart';

class AllAudioControllerWidgets extends StatelessWidget {
  const AllAudioControllerWidgets({
    super.key,
    required this.playPauseIcon,
    required this.volumeIcon,
    required this.downloadIcon,
    required this.onTap,
    required this.volumeOnPressed,
    required this.downloadOnPressed,
    this.volumeColor,
  });

  final IconData playPauseIcon;
  final VoidCallback onTap;
  final IconData volumeIcon;
  final void Function()? volumeOnPressed;
  final Color? volumeColor;
  final IconData downloadIcon;
  final VoidCallback downloadOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: volumeOnPressed,
          icon: Icon(
            volumeIcon,
            color: volumeColor ?? AppColors.white,
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
                onTap: onTap,
                borderRadius: BorderRadius.circular(100.r),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Icon(
                    playPauseIcon,
                    size: 30.r,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: downloadOnPressed,
          icon: Icon(
            downloadIcon,
            color: AppColors.white,
            size: 26.r,
          ),
        ),
      ],
    );
  }
}
