import 'package:flutter/material.dart';
import 'package:taski_todo/core/ui/styles/app_colors.dart';
import 'package:taski_todo/core/ui/styles/app_styles.dart';
import 'package:taski_todo/core/ui/styles/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static final _defaultInputBorder = InputBorder.none;

  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    primaryColor: AppColors.i.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.i.primary,
      primary: AppColors.i.primary,
      secondary: AppColors.i.secondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.i.primaryButton,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.all(13),
      hintStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey[400],
      ),
      border: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      errorBorder: _defaultInputBorder,
      disabledBorder: _defaultInputBorder,
      labelStyle: AppTextStyles.i.textRegular.copyWith(
        color: Colors.black,
      ),
      errorStyle: AppTextStyles.i.textRegular.copyWith(
        color: Colors.redAccent,
      ),
    ),
  );
}
