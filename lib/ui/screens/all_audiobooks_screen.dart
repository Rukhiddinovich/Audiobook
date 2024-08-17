import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Text(
              "My Books",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.cF5F5FA,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
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
                            context, RouteNames.audiobookScreen);
                      },
                      borderRadius: BorderRadius.circular(16.r),
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding:
                                  EdgeInsets.only(top: 10.h, bottom: 10.h),
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.asset(
                                    AppImages.exampleImage,
                                    fit: BoxFit.cover,
                                  )),
                              title: Text(
                                "The Black Witch",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.cF5F5FA,
                                ),
                              ),
                              subtitle: Text(
                                "Laurie Forest",
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
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.volume_down,color: AppColors.white,size: 26.r,)
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
                                          onTap: () {},
                                          borderRadius: BorderRadius.circular(100.r),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
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
                                      icon: Icon(CupertinoIcons.square_arrow_down,color: AppColors.white,size: 26.r,)
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
          ),
        ],
      ),
    );
  }
}
