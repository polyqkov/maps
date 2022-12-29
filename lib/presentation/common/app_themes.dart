import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

final appLightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  backgroundColor: AppColors.backgroundWhite,
  scaffoldBackgroundColor: AppColors.backgroundWhite,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.backgroundWhite,
    elevation: 0,
  ),
  primaryColor: AppColors.systemGray06Dark,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.systemGray06Dark,
    selectionColor: AppColors.systemGray06Dark.withOpacity(0.4),
    selectionHandleColor: AppColors.systemGray06Dark,
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
    color: AppColors.backgroundWhite,
    elevation: 0,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: AppColors.backgroundWhite,
    elevation: 0,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.systemGray06Dark,
    onPrimary: AppColors.backgroundWhite,
    secondary: AppColors.systemGray06Light,
    onSecondary: AppColors.systemGray06Dark,
    tertiary: AppColors.systemGray03Light,
    onTertiary: AppColors.systemGray06Dark,
    error: AppColors.systemRedLight,
    onError: AppColors.backgroundWhite,
    background: AppColors.backgroundWhite,
    onBackground: AppColors.backgroundBlack,
    surface: AppColors.systemGray04Light,
    onSurface: AppColors.systemGray06Dark,
    primaryContainer: AppColors.systemGray06Light,
    onPrimaryContainer: AppColors.systemGray06Dark,
  ),
);
