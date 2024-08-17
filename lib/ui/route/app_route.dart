part of 'app_route_part.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String allAudiobooksScreen = "/all_audiobooks_screen";
  static const String audiobookScreen = "/audiobook_screen";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.allAudiobooksScreen:
        return CupertinoPageRoute(
            builder: (context) => const AllAudiobooksScreen());
      case RouteNames.audiobookScreen:
        return CupertinoPageRoute(
          builder: (context) => AudiobookScreen(
            datum: (settings.arguments as List)[0] as Datum,
            index: (settings.arguments as List)[1] as int,
          ),
        );
      default:
        return CupertinoPageRoute(
            builder: (context) => _buildUnknownRoutePage());
    }
  }

  // static Route _buildPageRoute(Widget page) {
  //   return PageTransition(
  //     type: PageTransitionType.rightToLeft,
  //     reverseDuration: const Duration(milliseconds: 300),
  //     duration: const Duration(milliseconds: 300),
  //     child: page,
  //     curve: Curves.easeInOut,
  //   );
  // }

  static Widget _buildUnknownRoutePage() {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Center(
        child: Text(
          "Route not available!",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
