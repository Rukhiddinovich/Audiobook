import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uic_task/utils/color.dart';

class RowItemsWidgets extends StatelessWidget {
  const RowItemsWidgets({
    super.key,
    required this.imageUrl,
    required this.musicName,
    required this.artistName,
  });

  final String imageUrl;
  final String musicName;
  final String artistName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          width: 100.w,
          height: 80.h,
          errorWidget: (context, error, stackTrace) => Container(
            width: 100.w,
            height: 80.h,
            color: AppColors.c1C1C4D,
          ),
          imageUrl: imageUrl,
        ),
      ),
      title: Text(
        musicName,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.cF5F5FA,
        ),
      ),
      subtitle: Text(
        artistName,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.cEBEBF5,
        ),
      ),
    );
  }
}
