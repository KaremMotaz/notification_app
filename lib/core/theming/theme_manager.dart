import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors_manager.dart';
import 'text_styles.dart';

abstract class ThemeManager {
  static ThemeData getAppTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ColorsManager.white,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.white,
        centerTitle: true,
        titleTextStyle: TextStyles.bold22.copyWith(color: ColorsManager.black),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorsManager.black,
        ),
      ),
    );
  }
}
