import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uic_task/utils/color.dart';
import 'package:uic_task/utils/icons.dart';

class AudiobookScreen extends StatelessWidget {
  const AudiobookScreen({super.key});

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
        title: Text(
          "My Books",
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
                child: Image.asset(AppImages.exampleImage, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 28.h, bottom: 4.h),
              child: Text(
                "Harry Potter and the Prison...",
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
              "J.K. Rowling",
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
              padding: EdgeInsets.only(top: 30.h, bottom: 16.h),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 20.h),
                  child: Column(
                    children: [
                      Slider(
                        value: 0.2,
                        inactiveColor: AppColors.cDDD7FC,
                        activeColor: AppColors.c4838D1,
                        onChanged: (value) {},
                      ),
                      Row(
                        children: [
                          Text(
                            "00:00",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.c9292A2,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "12:30",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.c9292A2,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.shuffle_rounded,
                              size: 30.r,
                              color: AppColors.white,
                            )
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(CupertinoIcons.chevron_left_circle,color: AppColors.white,size: 35.r,)
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(100.r),
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.circular(100.r),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Icon(
                                            Icons.pause,
                                            size: 30.r,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(CupertinoIcons.chevron_right_circle,color: AppColors.white,size: 35.r,)
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
  }
}
