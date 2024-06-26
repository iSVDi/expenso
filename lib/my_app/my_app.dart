import 'package:expenso/common/app_preferences.dart';
import 'package:expenso/gen/l10n/app_localizations.dart';
import 'package:expenso/main.dart';
import 'package:expenso/modules/main/views/main_view.dart';
import 'package:expenso/modules/welcome/welcome.dart';
import 'package:expenso/theme/cubit/theme_mode_cubit.dart';
import 'package:expenso/theme/cubit/theme_mode_state.dart';
import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    notificationService.setListeners();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      notificationService.resetGlobalBadge();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var home = _getHomeWidget();
    var bloc = BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (builderContext, state) {
        var materialApp = MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme:ThemeProvider.getTheme(),
          darkTheme: ThemeProvider.getDarkTheme(),
          themeMode: state.themeMode,
          home: home,
        );
        return materialApp;
      },
    );

    return bloc;
  }

  Widget _getHomeWidget() {
    var needPresentOnBoarding = AppPreferences().getIsFirstLaunch();
    if (needPresentOnBoarding) {
      return const Welcome();
    }
    return const MainView();
  }
}
