// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:expenso/common/app_preferences.dart';
import 'package:expenso/gen/l10n/app_localizations.dart';
import 'package:expenso/theme/cubit/theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  final themeModePreferences = AppPreferences();
  ThemeModeCubit()
      : super(ThemeModeState(themeMode: AppPreferences().getThemeMode()));

  List<ThemeModeModel> getThemeModes(AppLocalizations localization) {
    return [
      ThemeModeModel(
          title: localization.systemThemeMode, mode: ThemeMode.system),
      ThemeModeModel(title: localization.darkThemeMode, mode: ThemeMode.dark),
      ThemeModeModel(title: localization.lightThemeMode, mode: ThemeMode.light),
    ];
  }

  void setNewThemeMode(ThemeMode themeModeName) async {
    await themeModePreferences.setThemeMode(themeModeName);
    var themeMode = themeModePreferences.getThemeMode();
    emit(ThemeModeState(themeMode: themeMode));
  }
}

class ThemeModeModel {
  String title;
  ThemeMode mode;

  ThemeModeModel({
    required this.title,
    required this.mode,
  });
}
