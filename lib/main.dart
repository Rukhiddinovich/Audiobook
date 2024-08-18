import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:uic_task/bloc/audiobook_bloc.dart';
import 'package:uic_task/data/local/local_database.dart';
import 'package:uic_task/ui/route/app_route_part.dart';
import 'package:uic_task/utils/color.dart';
import 'package:uic_task/utils/icons.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await StorageRepository.getInstance();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AudiobookBloc()..add(GetAudiobooksDataEvent()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: false,
            fontFamily: "Poppins",
            scaffoldBackgroundColor: AppColors.primaryColor,
            actionIconTheme: ActionIconThemeData(
              backButtonIconBuilder: (BuildContext context) => IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: SvgPicture.asset(
                  AppIcons.backIcon,
                  width: 24.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: AppRoutes.generateRoute,
          // home: MapScreen(),
        );
      },
    );
  }
}
