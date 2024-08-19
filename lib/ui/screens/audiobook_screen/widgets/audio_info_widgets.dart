import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uic_task/utils/color.dart';

class AudiobookInfoWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artistName;

  const AudiobookInfoWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.artistName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 28.h, bottom: 4.h),
          child: Text(
            title,
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
          artistName,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.white.withOpacity(0.5),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
