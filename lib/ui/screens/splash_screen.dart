import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uic_task/ui/route/app_route_part.dart';
import 'package:uic_task/utils/color.dart';
import 'package:uic_task/utils/icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, RouteNames.allAudiobooksScreen,
          (Route<dynamic> route) => false);
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
        ),
        child: Center(
          child: SvgPicture.asset(AppIcons.audiobookLogo, width: 200.w),
        ),
      ),
    );
  }
}
