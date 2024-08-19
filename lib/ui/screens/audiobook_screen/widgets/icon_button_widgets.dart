import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uic_task/utils/color.dart';

class IconButtonWidgets extends StatelessWidget {
  const IconButtonWidgets({
    super.key,
    required this.onPressed,
    required this.icon,
    this.iconColor,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 30.r,
        color: iconColor ?? AppColors.white,
      ),
    );
  }
}
