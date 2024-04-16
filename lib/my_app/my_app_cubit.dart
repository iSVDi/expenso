import 'package:expenso/modules/main/views/main_view.dart';
import 'package:expenso/modules/welcome/welcome.dart';
import 'package:expenso/theme/cubit/app_preferences.dart';
import 'package:flutter/material.dart';

class MyAppCubit {
  final appPreferences = AppPreferences();

  Widget getHomeWidget() {
    if (appPreferences.getIsFirstLaunch()) {
      return const Welcome();
    }
    return const MainView();
  }
}
