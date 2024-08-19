import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uic_task/utils/color.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSize {
  const GlobalAppBar({
    super.key,
    this.title,
    this.actionWidget,
    this.centerTitle,
    this.bottomWidgets, this.backgroundColor,
    this.statusBarColor,
    this.iconThemeColor
  });

  final Widget? title;
  final Widget? actionWidget;
  final bool? centerTitle;
  final PreferredSize? bottomWidgets;
  final Color? backgroundColor;
  final Color? statusBarColor;
  final Color? iconThemeColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      bottom: bottomWidgets,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: iconThemeColor ?? CupertinoColors.white),
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: statusBarColor ?? AppColors.primaryColor,
      ),
      title: title,
      centerTitle: centerTitle,
      actions: actionWidget != null ? [actionWidget!] : null,
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
