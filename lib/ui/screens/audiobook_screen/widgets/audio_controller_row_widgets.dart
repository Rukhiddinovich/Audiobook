import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioControllerRowWidgets extends StatelessWidget {
  final VoidCallback leftOnPressed;
  final IconData leftIcon;
  final VoidCallback onTap;
  final IconData playPauseIcon;
  final IconData rightIcon;
  final VoidCallback rightOnPressed;

  const AudioControllerRowWidgets({
    super.key,
    required this.leftOnPressed,
    required this.leftIcon,
    required this.onTap,
    required this.playPauseIcon,
    required this.rightIcon,
    required this.rightOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: leftOnPressed,
          icon: Icon(
            leftIcon,
            color: Colors.white,
            size: 35.r,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
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
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: rightOnPressed,
          icon: Icon(
            rightIcon,
            color: Colors.white,
            size: 35.r,
          ),
        ),
      ],
    );
  }
}
