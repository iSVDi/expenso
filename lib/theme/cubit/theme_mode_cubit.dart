import 'package:expenso/theme/cubit/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:expenso/theme/cubit/theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  final themeModePreferences = AppPreferences();
  ThemeModeCubit()
      : super(ThemeModeState(themeMode: AppPreferences().getThemeMode()));

// localize
  List<ThemeMode> getThemeModes() {
    return [ThemeMode.system, ThemeMode.dark, ThemeMode.light];
  }

  void setNewThemeMode(ThemeMode themeModeName) async {
    await themeModePreferences.setThemeMode(themeModeName);
    var themeMode = themeModePreferences.getThemeMode();
    emit(ThemeModeState(themeMode: themeMode));
  }
}
