import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/cubit/connectivity_cubit.dart';
import 'package:uic_task/ui/route/app_route_part.dart';
import 'package:uic_task/utils/color.dart';
import 'package:uic_task/utils/constants.dart';
import 'package:uic_task/utils/icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final ConnectivityCubit _connectivityCubit;
  bool? isConnect;
  late final StreamSubscription connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivityCubit = context.read<ConnectivityCubit>();
    _init();
  }

  Future<void> _init() async {
    connectivitySubscription =
        _connectivityCubit.stream.listen((connectivityStatus) {
      setState(() {
        isConnect = connectivityStatus == ConnectivityStatus.connected;
      });
    });

    await Future.delayed(const Duration(seconds: 3));

    myPrint("isConnect--------------->$isConnect");

    if (isConnect != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.allAudiobooksScreen,
        (route) => false,
        arguments: isConnect,
      );
    }
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
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
