import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color primaryColor = Color(0xFF0F0F29);
  static const Color c2E2E5D = Color(0xFF2E2E5D);
  static const Color c4838D1 = Color(0xFF4838D1);
  static const Color cDDD7FC = Color(0xFFDDD7FC);
  static const Color cBBB1FA = Color(0xFFBBB1FA);
  static const Color cEBEBF5 = Color(0xFFEBEBF5);
  static const Color cF5F5FA = Color(0xFFF5F5FA);
  static const Color c1C1C4D = Color(0xFF1C1C4D);
  static const Color c6A6A8B = Color(0xFF6A6A8B);
  static const Color c9292A2 = Color(0xFF9292A2);


  static const Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.14, 0.70, 1.5],
    colors: [
      AppColors.c2E2E5D,
      AppColors.primaryColor,
      AppColors.primaryColor,
      AppColors.c2E2E5D,
    ],
  );
}
