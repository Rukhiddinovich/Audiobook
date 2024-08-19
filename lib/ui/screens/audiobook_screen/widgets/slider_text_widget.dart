import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uic_task/utils/color.dart';

class SliderTextWidget extends StatelessWidget {
  const SliderTextWidget({
    super.key,
    required this.textPosition,
    required this.textDuration,
  });

  final String textPosition;
  final String textDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Text(
            textPosition,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: AppColors.c9292A2,
            ),
          ),
          const Spacer(),
          Text(
            textDuration,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: AppColors.c9292A2,
            ),
          ),
        ],
      ),
    );
  }
}
