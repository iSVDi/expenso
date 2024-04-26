import 'package:expenso/common/app_preferences.dart';
import 'package:expenso/l10n/gen_10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenso/theme/cubit/theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  final themeModePreferences = AppPreferences();
  ThemeModeCubit()
      : super(ThemeModeState(themeMode: AppPreferences().getThemeMode()));

  List<(String title, ThemeMode mode)> getThemeModes(
      AppLocalizations localization) {
    return [
      (localization.systemThemeMode, ThemeMode.system),
      (localization.darkThemeMode, ThemeMode.dark),
      (localization.lightThemeMode, ThemeMode.light),
    ];
  }

  void setNewThemeMode(ThemeMode themeModeName) async {
    await themeModePreferences.setThemeMode(themeModeName);
    var themeMode = themeModePreferences.getThemeMode();
    emit(ThemeModeState(themeMode: themeMode));
  }
}
